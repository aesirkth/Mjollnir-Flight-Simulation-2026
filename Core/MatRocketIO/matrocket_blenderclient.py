import bpy
import mathutils
import sys
import os
import numpy
import json
import time

# Add Lib folder to Python path
LIB_PATH = os.path.dirname(__file__)
if LIB_PATH not in sys.path:
    print("lib path:")
    print(LIB_PATH)
    sys.path.append(LIB_PATH)

import matrocketIO


global RUNNING, first_update, ARROWS, mtr, shared_state
RUNNING       = True
first_update  = False
ARROWS        = True


def blender_command_pump():
    global mtr, blenderstate

    blenderstate = {"status":"not ready"}
    shared_state.sync_remote(blenderstate)

    shared_state.sync_local()

    blenderstate = {"status":"ready"}
    shared_state.sync_remote(blenderstate)


    return 0.01


def delta_to_blender(state):
    for key in state.keys():
        if key in bpy.data.objects.keys():
            delta = state[key]
            
            if "t" in delta.keys():
                bpy.context.scene.frame_current = round(delta["t"]*30)
            update_blender_transforms(delta, bpy.data.objects[key])
            if ARROWS:
                update_arrows(delta, bpy.data.objects[key])


def update_blender_transforms(stateobj, blenderobj):
    if "position" in stateobj.keys():
        blenderobj.location            = mathutils.Vector(stateobj["position"])
        blenderobj.keyframe_insert("location")
    if "attitude" in stateobj.keys():
        blenderobj.rotation_mode       = 'QUATERNION'
        blenderobj.rotation_quaternion = mathutils.Matrix(numpy.array(stateobj["attitude"]).tolist()).to_quaternion()
        blenderobj.keyframe_insert("rotation_quaternion")

    for child_name in stateobj.keys():
        blenderobj_child_names = list(blenderobj.children[index].name for index in range(0,len(blenderobj.children)))
        if child_name in blenderobj_child_names and isinstance(stateobj[child_name], dict):
            blender_child_index = blenderobj_child_names.index(child_name)
            update_blender_transforms(stateobj[child_name], blenderobj.children[blender_child_index])



def update_arrows(stateobj, blenderobj):

    for child_name in stateobj.keys():

        if child_name == "wind_velocity_absolute":
            full_ID = blenderobj.name + "_wind_velocity_absolute"
            # add in missing vectors that did not come with the CAD model
            if not full_ID in bpy.data.objects.keys():
                bpy.ops.object.empty_add(align ='WORLD', location=(0, 0, 0), scale=(1, 1, 1))
                bpy.data.objects["Empty"].name                                        = full_ID
                bpy.data.objects[full_ID].parent                                      = blenderobj.parent
                bpy.data.objects[full_ID].hide_render                                 = True
                bpy.data.objects[full_ID].hide_viewport                               = True

                bpy.ops.object.empty_add(align ='WORLD', location=(0, 0, 0), scale=(1, 1, 1))
                bpy.data.objects["Empty"].name                                        = full_ID+"_vector"
                bpy.data.objects[full_ID+"_vector"].parent                            = bpy.data.objects[full_ID]
                bpy.data.objects[full_ID+"_vector"].hide_render                       = True
                bpy.data.objects[full_ID+"_vector"].hide_viewport                     = True

                bpy.ops.object.empty_add(type='SINGLE_ARROW', align='WORLD', location =(0, 0, 0), scale=(1, 1, 1))
                bpy.data.objects["Empty"].name                                        = full_ID+"_arrow"
                bpy.data.objects[full_ID+"_arrow"].parent                             = bpy.data.objects[full_ID+"_vector"]
                bpy.data.objects[full_ID+"_arrow"].constraints.new(type='TRACK_TO')
                bpy.data.objects[full_ID+"_arrow"].constraints["Track To"].target     = bpy.data.objects[full_ID]
                bpy.data.objects[full_ID+"_arrow"].constraints["Track To"].track_axis = 'TRACK_Z'


            bpy.data.objects[full_ID+"_vector"].keyframe_insert("location")
            bpy.data.objects[full_ID+"_arrow" ].keyframe_insert("scale")
            bpy.data.objects[full_ID+"_vector"].location = -mathutils.Vector(stateobj["wind_velocity_absolute"])/1000
            bpy.data.objects[full_ID+"_arrow" ].scale    =  mathutils.Vector([1,1,1])*bpy.data.objects[full_ID+"_vector"].location.length
        

        if child_name == "forces" or child_name == "moments":
            for vector_name in stateobj[child_name].keys():
                full_ID = blenderobj.name + "_" + vector_name
                # add in missing vectors that did not come with the CAD model
                if not full_ID in bpy.data.objects.keys():
                    bpy.ops.object.empty_add(align ='WORLD', location=(0, 0, 0), scale=(1, 1, 1))
                    bpy.data.objects["Empty"].name                                       = full_ID
                    bpy.data.objects[full_ID].parent                                     = blenderobj
                    bpy.data.objects[full_ID].hide_render                                = True
                    bpy.data.objects[full_ID].hide_viewport                              = True

                    bpy.ops.object.empty_add(align ='WORLD', location=(0, 0, 0), scale=(1, 1, 1))
                    bpy.data.objects["Empty"].name                                       = full_ID+"_vector"
                    bpy.data.objects[full_ID+"_vector"].parent                           = bpy.data.objects[full_ID]
                    bpy.data.objects[full_ID+"_vector"].hide_render                      = True
                    bpy.data.objects[full_ID+"_vector"].hide_viewport                    = True

                    bpy.ops.object.empty_add(type='SINGLE_ARROW', align='WORLD', location=(0, 0, 0), scale=(1, 1, 1))
                    bpy.data.objects["Empty"].name                                       = full_ID+"_arrow"
                    bpy.data.objects[full_ID+"_arrow"].parent                            = bpy.data.objects[full_ID]
                    bpy.data.objects[full_ID+"_arrow"].constraints.new(type='TRACK_TO')
                    bpy.data.objects[full_ID+"_arrow"].constraints["Track To"].target     = bpy.data.objects[full_ID+"_vector"]
                    bpy.data.objects[full_ID+"_arrow"].constraints["Track To"].track_axis = 'TRACK_Z'




                if "position" in stateobj[child_name][vector_name].keys():
                    bpy.data.objects[full_ID].keyframe_insert("location")
                    bpy.data.objects[full_ID].location           = mathutils.Vector(stateobj[child_name][vector_name]["position"])
                
                if "vector" in stateobj[child_name][vector_name].keys():
                    bpy.data.objects[full_ID+"_vector"].keyframe_insert("location")
                    bpy.data.objects[full_ID+"_arrow" ].keyframe_insert("scale")
                    bpy.data.objects[full_ID+"_vector"].location = mathutils.Vector(stateobj[child_name][vector_name]["vector"])
                    bpy.data.objects[full_ID+"_arrow" ].scale    = mathutils.Vector([1,1,1])*bpy.data.objects[full_ID+"_vector"].location.length/10

        blenderobj_child_names = list(blenderobj.children[index].name for index in range(0,len(blenderobj.children)))
        if child_name in blenderobj_child_names and isinstance(stateobj[child_name], dict):
            blender_child_index = blenderobj_child_names.index(child_name)
            update_arrows(stateobj[child_name], blenderobj.children[blender_child_index])




shared_state = matrocketIO.remote_state()
shared_state._encoding_layer.parse_method = delta_to_blender
bpy.app.timers.register(blender_command_pump)