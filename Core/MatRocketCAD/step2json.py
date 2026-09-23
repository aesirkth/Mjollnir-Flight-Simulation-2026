import os
from pathlib import Path

import FreeCAD
import Import
import MeshPart
import json
import re
import numpy as np
import quaternion
import sys



global doc, step_file, out_dir, namelist
namelist = []

def rename(name):
    global namelist
    name = re.sub(r'^(?=\d)', 'N', name)
    name = re.sub(r'[^A-Za-z0-9]', '', name)
    if bool(re.search(r'v\d+$', name)):
        name = re.sub('\W+','', name ).rsplit("v", 1)[0]
        namelist.append(name)
        if namelist.count(name) > 1:
            name += str(namelist.count(name))
    return name


class CustomMesh:
    def __init__(self, name="mesh"):
        self.name = name
        self.vertices  = []  # list of 3-tuples (x, y, z)
        self.triangles = []  # list of 3-tuples (indices into vertices)
        self.normals   = []  # optional, one per triangle

    def add_triangle(self, v0, v1, v2):
        """Add a triangle using three vertices"""
        idx0 = len(self.vertices)
        self.vertices .append(tuple(v0))
        self.vertices .append(tuple(v1))
        self.vertices .append(tuple(v2))
        self.triangles.append((idx0, idx0+1, idx0+2))
        # default normal = zero (can be computed later)
        self.normals.append((0.0, 0.0, 0.0))

    def from_freecad_mesh(self, fc_mesh):
        """
        Copy all triangles from a FreeCAD Mesh.Mesh object into this CustomMesh.
        fc_mesh: Mesh.Mesh instance
        """
        for f in fc_mesh.Facets:
            # FreeCAD facet points may be tuples or FreeCAD.Vectors
            v0 = f.Points[0]
            v1 = f.Points[1]
            v2 = f.Points[2]

            # Ensure we have tuples
            if not isinstance(v0, tuple):
                v0 = (v0.x, v0.y, v0.z)
                v1 = (v1.x, v1.y, v1.z)
                v2 = (v2.x, v2.y, v2.z)

            self.add_triangle(v0, v1, v2)

    def apply_transform(self, matrix, translation):
        """Apply a 3x3 rotation/scaling matrix and optional translation vector"""
        new_vertices = []
        for v in self.vertices:
            v_np = np.array(v)
            v_np = v_np + translation
            v_np = (matrix @ v_np)/1000
            new_vertices.append(tuple(v_np))
        self.vertices = new_vertices

    def write_ascii(self, filename):
        with open(filename, "w") as f:
            f.write(f"solid {self.name}\n")
            for tri_idx, (i0, i1, i2) in enumerate(self.triangles):
                n = self.normals[tri_idx]
                f.write(f"  facet normal {n[0]} {n[1]} {n[2]}\n")
                f.write("    outer loop\n")
                f.write(f"      vertex {self.vertices[i0][0]} {self.vertices[i0][1]} {self.vertices[i0][2]}\n")
                f.write(f"      vertex {self.vertices[i1][0]} {self.vertices[i1][1]} {self.vertices[i1][2]}\n")
                f.write(f"      vertex {self.vertices[i2][0]} {self.vertices[i2][1]} {self.vertices[i2][2]}\n")
                f.write("    endloop\n")
                f.write("  endfacet\n")
            f.write(f"endsolid {self.name}\n")

    def write_binary(self, filename):
        import struct
        with open(filename, "wb") as f:
            f.write(b' ' * 80)
            f.write(struct.pack('<I', len(self.triangles)))
            for tri_idx, (i0, i1, i2) in enumerate(self.triangles):
                n = self.normals[tri_idx]
                f.write(struct.pack('<3f', *n))
                f.write(struct.pack('<3f', *self.vertices[i0]))
                f.write(struct.pack('<3f', *self.vertices[i1]))
                f.write(struct.pack('<3f', *self.vertices[i2]))
                f.write(struct.pack('<H', 0))




# -----------------------------
def walk_object(obj, path="main", parent=None):
    """
    Recursively walk FreeCAD object hierarchy,
    export each solid as STL, build JSON with relative transform.
    """
    global doc, step_file, out_dir, namelist
    
    jsonobj  = {}
    if hasattr(parent, "getGlobalPlacement"):

        parent_position_global  = np.array(parent.getGlobalPlacement().Base)
        obj_position_global     = np.array(obj   .getGlobalPlacement().Base)
        x, y, z, w              = parent.getGlobalPlacement().Rotation.Q
        quat                    = quaternion.quaternion(w,x,y,z)
        parent_attitude_global  = quaternion.as_rotation_matrix(quat)
        x, y, z, w              = obj.getGlobalPlacement().Rotation.Q
        quat                    = quaternion.quaternion(w,x,y,z)
        obj_attitude_global     = quaternion.as_rotation_matrix(quat)
        relative_position       = np.linalg.inv(parent_attitude_global) @ (obj_position_global - parent_position_global) 
        relative_attitude       = np.linalg.inv(parent_attitude_global) @ obj_attitude_global

    else:
        print(obj.Label)
        obj_position_global     = np.array(obj.getGlobalPlacement().Base)
        parent_position_global  = np.array([0,0,0])
        x, y, z, w              = obj.getGlobalPlacement().Rotation.Q
        quat                    = quaternion.quaternion(w,x,y,z)
        obj_attitude_global     = quaternion.as_rotation_matrix(quat)
        parent_attitude_global  = np.array([[1,0,0],[0,1,0],[0,0,1]])
        relative_position       = obj_position_global 
        relative_attitude       = obj_attitude_global


    jsonobj["position"]         = (relative_position/1000).tolist()
    jsonobj["attitude"]         = (relative_attitude).tolist()


    if obj.TypeId in ("Part::Feature", "PartDesign::Body"):
        stl_path = f"{path}.stl"
        
        freecad_mesh       = MeshPart.meshFromShape(
                                                    Shape= obj.Shape,
                                                    LinearDeflection=0.05,
                                                    AngularDeflection=0.1
                                                    )
        
        mymesh             = CustomMesh()
        mymesh.from_freecad_mesh(freecad_mesh)
        mymesh.apply_transform( np.linalg.inv(relative_attitude), -relative_position)
        mymesh.write_ascii(out_dir+"\\"+str(stl_path))
        jsonobj["mesh"]= str(stl_path)

        print(f"Exported STL: {stl_path}")


    if hasattr(obj, "OutList"):
        for i, child in enumerate(obj.OutList):
            if not child.TypeId in ("App::OriginFeature"):
                child_name = rename(child.Label)
                child.Label = child_name
                jsonobj[child_name] = walk_object(child, child_name, obj)


    return jsonobj

# -----------------------------
def main():
    global doc, step_file, out_dir
    print("Creating document...")
    doc = FreeCAD.newDocument("doc")

        # Expect: freecadcmd converter.py input_step output_dir
    if len(sys.argv) != 4:
        print("Usage: freecadcmd converter.py path_to_step_file path_to_output")
        print(sys.argv)
        return
    
    print(sys.argv)
    step_file = sys.argv[2]
    out_dir   = sys.argv[3]
    outpath   = Path(out_dir)
    outpath.mkdir(exist_ok=True)
    print(f"Importing STEP file: {step_file}")
    Import.insert(step_file, doc.Name)
    

    jsonobj = {}

    top_level_objects = [obj for obj in doc.Objects if not obj.InList]
    

    for i, obj in enumerate(top_level_objects):

        if hasattr(obj, "Shape") and obj.Shape and len(obj.Shape.Solids) > 0:
            obj_name = rename(obj.Label)
            jsonobj[obj_name] = walk_object(obj, obj_name, )

    json_path = out_dir + "\\hierarchy.json"
    with open(json_path, "w") as f:
        json.dump(jsonobj, f, indent=2)

    print(f"Done. JSON saved to {json_path}")
    # Export GLB (headless-safe)
    glb_path = os.path.join(out_dir, "BlenderModel.glb")

    # Export all top-level objects
    for obj in top_level_objects: obj.Label = rename(obj.Label)
    Import.export(top_level_objects, glb_path)

    print(f"GLB exported to {glb_path}")


main()