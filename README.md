# Welcome to MatRocket!

![](./assets/launch2.png)

<br><br>

## About

This is the MatRocket documentations page. MatRocket is a simulation tool built to take your idea from simulation to air in minimum time. MatRocket is built by engineers, for engineers, to aid you in the the design & validation workflow.

<br>

### What MatRocket is not:
* Built for hobbyists (though hobbyists are of course welcome to use it). Hence, MatRocket is built for customizability before "open-and-hit-run".
* Built for operations/game-like usage. MatRocket is built to be deterministic, and will thus prioritize accuracy over speed. If a system is dynamic and chaotic, the simulation will slow down to compensate.
* Validated! See this as an open call for any flight-data available to calibrate from.
* Built for MAC/Linux. Yet. Some features might work, but no garantuee's on this one.

<br>

### What MatRocket is:
* MatRocket works out of the box, though it is built from the ground up to be extendable. It's built in layers, allowing you to, if you want, throw out the entire physics engine and build your own ( though I don't recommend it for your own sanity's sake ). It can, and has been, made to interact with hardware, analyze transfer functions, model propulsion systems, control systems, interface with other software, etc. The idea is for all the different diciplines in a rocketry project to have a common "hub" to which they can apply their models; the control-team, the propulsion-team, the recovery-team all work and benchmark based on the same simulation. A recovery engineer needs a good propulsion model just as much as a propulsion engineer, as the recovery engineer needs to know what apogee the rocket is going to reach, etc.
* MatRocket has a UI for beginners, though it's features are really best utilized through scripting.
* MatRocket has an aerodynamics model that is really well suited for control system modelling as well as range-validation under wind-shear, as it models energy dissipation and damping really well.
* CAD-downstream! MatRocket uses a .step-file for most of the geometry-calculations, so the CAD and the simulations can be kept up to date, thus the designer and simulations engineers work on the same design, and can share feedback.
* MatRocket is ODE-based and fully explicit in difference to traditional game engines that are implicit, meaning the solver has no information about the system itself.
* MatRocket is written in MATLAB, and any scripting is done in MATLAB.

<br><br><br>

# Installation

Download/clone the project and extract the zip-file. 

Click installer.bat, this will install all the dependencies.

Click the MatRocketUI - file, run it from MATLAB  or add the path to the directory inside your MATLAB project for scripting.

<br><br><br>


# Quick-refence:
* [Welcome to MatRocket!](#welcome-to-matrocket)
    * [About](#about)
        * [What MatRocket is not](#what-matrocket-is-not)
        * [What MatRocket is](#what-matrocket-is)
* [Installation](#installation) : How to install
* [Quick-reference](#quick-refence)
* [MatRocketUI guide](#matrocket-ui-guide) : A quick-guide for working with the UI, as well as underlying Function-calls for scripting.
    * [Geometry](#geometry)
        * [Scripting](#scripting)
    * [Modelling](#modelling)
        * [Scripting](#scripting-1)
    * [Simulation](#simulation)
        * [Sripting](#scripting-2)
    * [Results](#results)
        * [Scripting](#scripting-3)
* [MatRocket scripting & architecture](#matrocket-scripting--architecture) : Solver structure, responsibilities, and architecture.
    * [Architecture](#architecture)
    * [Solver](#solver)
    * [Math & physics convention](#math--physics-convention)
* [Model documentation](#model-documentation) : Documentation on what the base MatRocket models do.
    * [Model specification](#model-specification) : How to write a model, and what to think about.
    * [base_HRAP_propulsion_model](#base_hrap_propulsion_model)
    * [base_aerodynamics_model](#base_aerodynamics_model)
    * [base_atmosphere_from_dataset_model](#base_atmosphere_from_dataset_model)
    * [base_blender_update](#base_blender_update)
    * [base_drag_coefficient_model](#base_drag_coefficient_model)
    * [base_dual_deployment_model](#base_dual_deploy_parachute_model)
    * [base_equations_of_motion_model](#base_equations_of_motion_model)
    * [base_gravity_model](#base_gravity_model)
    * [base_ground_interaction_model](#base_ground_interaction_model)
    * [base_manual_atmosphere_model](#base_manual_atmosphere_model)
    * [base_hybrid_propulsion_model](#base_hybrid_propulsion_model)
    * [base_single_deploy_parachute_model](#base_single_deploy_parachute_model)
    * [base_update_center_of_mass](#base_update_center_of_mass)
    * [base_update_forces](#base_update_forces)
    * [base_update_velocity](#base_update_velocity)
* [MatRocketCAD](#matrocketcad) : API documentation for how to import and manipulate CAD-files.
    * [importSTEP](#importstep) : Main import function for importing .step-file into MATLAB.
    * [draw_rocket](#draw_rocket) : Draw the rocket geometry, or any subcomponents imported via importSTEP.
* [MatRocketIO](#matrocketio) : Function documentation for the MatRocket communications protocol, for HIL & other software interactions.
    * [remote_state (API-layer)](#remote_state-api-layer) : The standard entry-point when using MatRocketIO.
        * [sync_local](#sync_local)
        * [sync_remote](#sync_remote)
        * [(state_update)](#state_update)
    * [encoding_layer](#encoding_layer) : Underlying encoding architecture.
        * [read](#read)
        * [write](#write)
        * [delete](#delete)
        * [read_bytes](#read_bytes)
        * [parse_buffer](#parse_buffer)
        * [parse_input_queue](#parse_input_queue)
        * [parse_method](#parse_method)
* [Utils](#utils) : Helper functions/ utilities used either in models or other.
    * [simulate_rocket](#simulate_rocket) : Runs the MatRocket simulation.
    * [struct_append](#struct_append) : Adds one nested struct over another, with priority to the second struct.
    * [struct_difference](#struct_difference) : Takes the delta between two nested structs, with priority to the second struct.
    * [setfield_safe](#setfield_safe) : Sets a field deep within a nested struct, creates new empty fields if fields are uninitiated.
    * [struct_printout](#struct_printout) : Prints out a tree of the entire nested struct in the terminal for easier visualization.
    * [force_vector](#force_vector) : Encapsulation of force vector.
    * [moment_vector](#moment_vector) : Encapsulation of moment vector.


<br><br><br>

# MatRocket UI guide
This is the MatRocket UI. The UI is divided up into workspaces, with each workspace working in a similar fashion. Each workspace allows you to edit/taylor/visualize some aspect of the simulation, and are ordered by workflow, meaning each workspace's output is the input to the next workspace.
![](./assets/Screenshot%202026-02-24%20104439.png)


When opening a workspace, you are greeted with an empty workspace config. The config includes all the information related to the session, and can be saved and loaded at a later time. The output from one workspace is the input to the next workspace, etc.

![](./assets/workflow.png)

<br>

### Scripting:

The different workspaces all import their configs as .mat-files, but for the .mat-file to be parseable by the correct workspace, and to know how to load/save variables when scripting, a spec for the correct fieldnames in the different .mat-files is provided. 

In general, all fields are organized in the same way, as the main rocket object consisting of a nested [struct](https://se.mathworks.com/help/matlab/ref/struct.html), more about this in  [MatRocket scripting & architecture](#matrocket-scripting--architecture).


| Workspace/tab    | default .mat-file | content | purpose | 
| -------- | ------- | ------- | ------- |
| geometry  | geometry_config.mat | rocket_default_values | Default values that are directly derived from the CAD-file. Source-of-truth. |
|   |  | rocket_overloaded_values | User-specified overloaded values, persistent & independent of CAD-file. |
|   |  | rocket_prebaked | The combined result of the default values and the user-overloaded values. |
| modelling  | initial_values_config.mat | rocket_prebaked | The raw rocket struct without any models applied. Original source of truth. |
|  |  | rocket_default_values | default values after the model-stack has been applied (baked) to the prebaked rocket. |
|  |  | rocket_overloaded_values | User-specified overloaded values, persistent & independent of underlying models. |
|  |  | rocket_initial_values | The combined result of the default values and the user-defined overloaded values. |
| simulation | initial_values_config_simulated.mat | rocket_initial_values | Initial values conditions for the simulation. |
||| rocket_results | The results from the simulation. |

<br><br>

## Geometry

The geometry workspace allows you to import CAD-files, and manipulate the rocket's geometry. 

![](./assets/Screenshot%202026-02-24%20094227.png)

When you open a workspace, you are greeted with an empty workspace config. To add geometry, import a .step-file.
The 'Edit geometry' panel now allows you to edit the geometry parameters. To find the parameters to a specific body, hide/unhide the other bodies in the check-box tree:

![](./assets/Screenshot%202026-02-24%20094256.png)

Editing the fields allows you to move/scale/rotate specific bodies. The editfields take in [json](https://en.wikipedia.org/wiki/JSON#Syntax)-formatted vectors/matrices:

![](./assets/Screenshot%202026-02-24%20094442.png)

The base-MatRocket workspaces are built such that modifications to the geometry are persistent even though you load a new CAD-file. That means that if you move/scale/rotate a component, so long as the new CAD-file also has that component, it is also going to have those transforms applied. This is to save you labour, and make it easier to keep the CAD/simulations up to date.

<br>

**Editable fieldnames:**
| input/property | type | description |
| ----- | ----- | ----- |
| component.position | 3x1 json-vector |the position of the component. For basis/convention, see [Math & physics convention](#math--physics-convention)  |
| component.attitude | 3x3 json-matrix | orientation of the component. For basis/convention, see [Math & physics convention](#math--physics-convention) |
| component.mesh_scale | 3x3 json-matrix | scale of the mesh, can be used to resize components without affecting the children |
| component.mesh | json-string | Path to stl-file describing the component geometry, see [importSTEP](#importstep) |
| component.is_rigid_body | json true/false | boolean describing whether physics calculations should be performed on the component, see [base_update_center_of_mass](#base_update_center_of_mass), [base_update_forces](#base_update_forces), [base_update_velocity](#base_update_velocity), [base_equations_of_motion_model](#base_equations_of_motion_model), [base_aerodynamics_model](#base_aerodynamics_model) |
| component.independent_aerodynamics | json true/false | boolean describing whether or not aerodynamic calculations should be done on the component, see [base_aerodynamics_model](#base_aerodynamics_model) |
| component.is_body | json true/false | boolean describing whether or not the component has geometry or not, tells the draw-command which components to draw or not |
| compoment.aerodynamics_persistent_flag | json true/false | boolean, tells the [base_aerodynamics_model](#base_aerodynamics_model) to ignore the component during cleanup, otherwise the base_aerodynamics_model removes redundant components to save on performance |



In general, the geometry-workspace can be seen as a pre-processor for the [base_aerodynamics_model](#base_aerodynamics_model), as that's main model that is directly affected by the rocket's geometry.

<br>

### Scripting:
Scripting the geometry-edits is especially useful if doing parameter-studies for example. Then, you can import the geometry or a step-file, and then move/scale/rotate a component incrementally, to see how it affects the resulting simulation.

Scripting the CAD-import:

``` MATLAB
rocket_default_values = importSTEP("path/to/step/file.step");

save("geometry_config.mat", "rocket_default_values", '-mat', 'append')

```

Overloading with custom values either directly:

``` MATLAB
load("geometry_config.mat","rocket_default_values")

rocket_prebaked = rocket_default_values;

rocket_prebaked.AD01Nosecone.position = [0;0;2];
rocket_prebaked.AD01Nosecone.attitude = rotx(45);

save("geometry_config.mat", "rocket_prebaked", '-mat', 'append')

```

Or indirectly (UI style):

``` MATLAB
load("geometry_config.mat","rocket_default_values")


rocket_overloaded_values = struct();
rocket_overloaded_values.AD01Nosecone = struct();
rocket_overloaded_values.AD01Nosecone.position = 
[0;0;2];
rocket_overloaded_values.AD01Nosecone.attitude = rotx(45);


rocket_prebaked = struct_append(rocket_default_values, rocket_overloaded_values);


save("geometry_config.mat", "rocket_prebaked", "rocket_overloaded_values" '-mat', 'append')

```

See [struct_append](#struct_append).

It can also be done a bit terser using [setfield_safe](#setfield_safe): 


``` MATLAB
load("geometry_config.mat","rocket_default_values")


rocket_overloaded_values = struct();
rocket_overloaded_values = setfield_safe(rocket_overloaded_values, {"AD01Nosecone", "position"},[0;0;2]);
rocket_overloaded_values = setfield_safe(rocket_overloaded_values, {"AD01Nosecone", "attitude"},rotx(45));

rocket_prebaked = struct_append(rocket_default_values, rocket_overloaded_values);


save("geometry_config.mat", "rocket_prebaked", "rocket_overloaded_values" '-mat', 'append')

```



Now, if making a study of fin-position for example:

``` MATLAB
load("geometry_config.mat","rocket_default_values");

rockets_prebaked = repmat(rocket_default_values, 10);

base_position = [0;0;0];

for index = 1:10

rocket_prebaked = rockets_prebaked(index);
rocket_prebaked.AB00XMasterPropulsionAssembly.BA00FinCanTube.position = base_position;
base_position = base_position + [0;0;0.1];
save("geometry_config("+string(index)+").mat" ,"rocket_prebaked")
end


```

For a guide on .mat-file fieldnames, see [MatRocketUI : Scripting](#scripting)

<br><br>

## Modelling

This is the modelling workspace, and is where you import/write models, and tweak the system's initial values. This controls all the "dynamics" of the system.

![](./assets/models.png)

For more information on what a model is, see [Model documentation](#model-documentation).

For more information on how to write a model, see [Model specification](#model-specification).

For more information on the fieldnames, see [Model documentation](#model-documentation).

In the active-models panel, the models are executed from top to bottom during actual simulation.

The default model stack describe a basic "runnable out of the box" simulation. Models can then be added/subtracted to the simulation-stack based on the simulation profile, and the initial values edited depending on the conditions and the rocket by filling in the editfields with the corresponding [json](https://en.wikipedia.org/wiki/JSON#Syntax). 

To find values easier, hide/unhide containers in the checkbox-tree.

Importing a new pre-baked config into the existing workspace does not remove any already assigned/edited initial values in the Edit initial values panel, allowing you to easily keep the initial_values_config up to date.

<br>

### Scripting:

The equivalent to the above, in scripting, would be:

Applying the models (baking):
``` MATLAB
load("geometry_config.mat", "rocket_prebaked");


rocket_default_values = bake_rocket(rocket_prebaked, true);


save("initial_values_config.mat", "rocket_default_values", "rocket_prebaked");
```

Overloading with custom values either directly:

``` MATLAB
load("initial_values_config.mat", "rocket_default_values");


rocket_intial_values = rocket_default_values;
rocket_initial_values.atmosphere.wind_velocity = [4;3;0];


save("initial_values_config.mat", "rocket_initial_values",'-mat', '-append');
```

Or indirectly (UI-style):

``` MATLAB
load("initial_values_config.mat", "rocket_default_values");


rocket_overloaded_values = struct();
rocket.overloaded_values.atmosphere = struct();
rocket.overloaded_values.atmosphere.wind_velocity = [4;3;0];

rocket_initial_values = struct_append(rocket_default_values, rocket_overloaded_values);


save("initial_values_config.mat", "rocket_initial_values",'-mat', '-append');
```
See [struct_append](#struct_append).

It can also be done a bit terser using [setfield_safe](#setfield_safe): 

``` MATLAB
load("initial_values_config.mat", "rocket_default_values");


rocket_overloaded_values = setfield_safe(struct(), {"atmosphere", "wind_velocity"}, [4;3;0]);

rocket_initial_values = struct_append(rocket_default_values, rocket_overloaded_values);


save("initial_values_config.mat", "rocket_initial_values", "rocket_overloaded_values",'-mat', '-append');
```


Now, if making a study of wind-conditions for example:

``` MATLAB
load("initial_values_config.mat", "rocket_default_values");

rockets_initial_values = repmat(rocket_default_values, 10,1);

for index = 1:10
rocket_initial_values = rockets_initial_values(index);
rocket_initial_values.atmosphere.wind_velocity = rand(3,1)*10;
save("initial_values_config("+string(index)+").mat", "rocket_initial_values")

end

```
For a guide on .mat-file fieldnames, see [MatRocketUI : Scripting](#scripting)


<br><br>

## Simulation
This is the MatRocket simulation workspace, and it allows you to load, and run multiple simulations, either in sequence or in parallel.
![](./assets/Screenshot%202026-02-24%20205057.png)

When running the simulation, you are prompted with a folder-selection. Rather than choose the name of the output-file manualy, MatRocket just takes the name of the initial-value file and adds a "_simulated", and this is to make batch-running files easier without having to rename 50+ files.

<br>

### Scripting

Scripting a simulation-run usually looks like this:

```MATLAB

load("initial_values_config.mat", "rocket_initial_values")

rocket_initial_values.ode_solver = @ode45;
rocket_initial_values.t_max      = 200;

rocket_results = simulate_rocket(rocket);

save("initial_values_config_simulated.mat", "rocket_results", '-mat', 'append')

```

See [simulate_rocket](#simulate_rocket).

<br><br>

## Results

This is the results-workspace, where you can visualize the simulated data. It is built for loading multiple simulations at the same time, to allow for easy comparison between data and simulation runs.


This is the Geoplotter, it allows you to visualize multiple trajectories over a geomap of the earth, with adjustable coordinates. Good for range-validation.
![](./assets/Screenshot%202026-02-25%20160513.png)


This is the 2D-plotter, that allows you to quickly visualize parameters from the simulation. Good for sizing and general engineering work. Select the parameter to plot by checking the corresponding box in the nodetree. All units are assumed to be base SI units in the base library.
![](./assets/Screenshot%202026-02-25%20160629.png)

This is the 3D-plotter, it allows you to visualize vector-valued parameters in 3D space, optionally together with parts of or the entire rocket. If the vector-valued parameter is on the same level as a position field, and that position field is checked, the vector root will be drawn from that position instead, for vectors where the origin might move around.
![](./assets/Screenshot%202026-02-25%20160926.png)

[NOTE!] In the 3D-plotter, the software does not automatically draw vectors and component parts in the same basis, it will only draw them in their own local basis. It is up to the user to draw the correct vectors with the correct parts.

<br>

### Scripting

Scripting the exact content in the results field has limited use, but scripting your own plots for generating specific visualizations can be useful if the plot type is not covered by the results tab.

For drawing geometry, see [draw_rocket]()

<br><br><br>

# MatRocket scripting & architecture

This part of the documentation describes the MatRocket architecture, why it looks the way it does, and how to utilize it in the best way.

<br><br>

## Architecture

MatRocket is built around the nested struct. This is for multiple reasons:

* **Readability** : Nested structs force the programmer to name substructs, and usually good naming is self evident enough to enforce a sort of 'self-documentation'. `rocket.engine.enthalpy` tells you a lot more than `h_e`.
* **Developer experience** : Since structs in MATLAB are dynamic, it provides a quite flexible and nice developer experience.
* **Interfacing with CAD** : CAD follows a hierarchy that maps very well to nested structs, hence it allows for seamless CAD integration.
* **json** : Nested structs allow for using json in protocols etc. 

Example of how a rocket struct might look:

```

rocket_initial_values = 

  struct with fields:

                        position: [3×1 double]
                        attitude: [3×3 double]
                         is_body: 1
        independent_aerodynamics: 1
    aerodynamics_persistent_flag: 0
                   is_rigid_body: 1
                          models: {1×7 cell}
                      derivative: [0×1 containers.Map]
                      atmosphere: [1×1 struct]
                    aerodynamics: [1×1 struct]
                      rigid_body: [1×1 struct]
                angular_momentum: [3×1 double]
                   rotation_rate: [3×1 double]
                        velocity: [3×1 double]
                            mass: 0
                          engine: [1×1 struct]
                          forces: [1×1 struct]
                      enviroment: [1×1 struct]
                     mass_summed: 1
           center_of_mass_summed: [3×1 double]
                    drogue_chute: [1×1 struct]
                      main_chute: [1×1 struct]
                   forces_summed: [1×1 struct]
                    acceleration: [3×1 double]
                      ode_solver: @realtime_ode


```


Or, using [struct_printout]():


Output:
```
struct with fields:
 ├───────────────────── position:  
 ├───────────────────── attitude:  
 ├────────────────────── is_body:  
 ├───── independent_aerodynamics:  
 ├─ aerodynamics_persistent_flag:  
 ├──────────────── is_rigid_body:  
 ├─────────────────────── models:  
 ├─────────────────── derivative:  
 ╞═══════════════════  atmosphere
 │                            ├── dataset_path:  
 │                            ├─ wind_velocity:  
 │                            ├─ is_rigid_body:  
 │                            ├─────── density:  
 │                            ├────── pressure:  
 │                            ├─── temperature:  
 │                            └ speed_of_sound:  
 ╞═════════════════  aerodynamics
 │                            ├──────── moment_of_area:  
 │                            ├────────── surface_area:  
 │                            ├────────── length_scale:  
 │                            ├── pressure_coefficient:  
 │                            ├── friction_coefficient:  
 │                            ├───────── is_rigid_body:  
 │                            ├────────────── position:  
 │                            ├────────────── attitude:  
 │                            ├────────────────── mass:  
 │                            ├───────── 
 
 
 
 
 
 ...


```

<br><br>

## Solver

![](./assets/matrocket_simulation_structure.png)

This is an overview of the MatRocket simulation structure (in this image the pre-processing has been bundled together into one script, same with the plotting/output). 


<br><br>

## Math & physics convention

<br>

### ODE-legality & determinism

MatRocket runs inside an ODE-solver, and hence the entire MatRocket simulation is formulated as an ODE. This is for a few reasons:

* It makes the system deterministic. Every time the simulation runs, it gives the same results.
* It makes the simulation glitch-free (not bug free!). A glitch is a very particular type of bug that occurs due to too large timesteps, and can cause the simulation to freak out. Performing the simulation inside an ODE means the ODE-solver is seperate from the system itself, and can, if need be, even go back in time to retry a certain sequence of events if it notices that it's particularly sensetive in that region.
* It unlocks the entire field of numerical and differential analysis to the MatRocket problem, and thus unlocks the whole toolbox of heavy mathematical machienery that comes with it.
* It makes the simulations more rigorously defined from a control-theory perspective.

**This does however come with some consequences, that are worth being aware of as a developer:**
* **MatRocket does not give you access to the timestep!** 
    - MatRocket is not a game engine, and you cannot affect the timestep or use it from within the simulation. You instead manipulate time-variable sequences with the derivative property, which will be covered shortly.
* **There is no persistent state across timesteps!** 
    - It means each timestep is decoupled, and only depend on the state vector.
* **Model-order matters!** 
    - This is a direct consequence of the above. All state is derived from the state-vector, and hence, models 'feed' into each other; if one model calculates something that the other model needs, it has to be before the other model in the simulation stack.


The core MatRocket simulation enviroment has an interface to make working with the ODE-nature more developer friendly to the developer, but it is worth knowing that underneath, there is state-vector logic happening.

Thus, MatRocket therefor assumes all models are written on the form:

$$\frac{d\vec{y}}{dt} = f(\vec{y},t)$$

To integrate properties, MatRocket gives you access to a subcomponent of the rocket called "derivative". By setting the derivative, you're telling the simulation engine: "integrate this parameter for me".

The derivative is intended to be write-only.


Usage example:
```MATLAB
rocket.derivative("position") = velocity;
```

The derivative property can also take in a longer string to a subcomponent:

```MATLAB
angular_velocity = 0.1;
rocket.derivative("control_tab.angle") = angular_velocity;
```

The internal MatRocket solver logic then converts this into a state vector, integrates it, and then takes that state-vector and writes the values back to the correct parameters in the rocket struct.

<br>

### Vector-basis
In base MatRocket, all vector-valued parameters are in the basis of the **grand-parent**. This might sound odd before seing it applied, but it means that:

* ` rocket.attitude` is in the world basis.
* ` rocket.position` is in the world basis.
* ` rocket.nosecone.attitude` is in the rocket basis.
* ` rocket.control_system.fin1.attitude` is in the control-system's basis.
* ` rocket.forces.LiftForce.vector` is in the forces-basis (since forces doesn't have a basis the basis is going to be it's parents, i.e the rockets).

<br>

### Units

In base MatRocket, all units are SI base units.


<br><br><br>

# Model documentation

As mentioned above, MatRocket encapsulates actions/simulation features into something called models. This is to seperate function and make the system modular. Each model has it's own responsibility that is prefferably independent from the other model, and usually encapsulates some aspect of the physics, this can be for example the equations of motion, the wind over different layers of atmoshpere, engine thrust-curves, etc.

<br><br>

## Model specification

A MatRocket model follows the following format:

```MATLAB

function rocket = my_model(rocket, declare_dependencies)
   % Generic model


   if declare_dependencies

     %% Model dependencies go here! These will be the default initial values, can be overwritten by user



   else

       %% Modelling and equations to be executed throughout simulation go here.



   end
end

```

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| rocket | struct | nested struct representing the entire rocket and its components/parameters |
| declare_dependencies | boolean | if true, the model runs it's pre-processor rather than the main model script. This is called during simulation initialization for example, and  in the UI where it's used to declare which paramerters are tuneable/tweakable by the user |

Usage example:

```MATLAB
function rocket = base_propulsion_model(rocket, declare_dependencies)
    
    if declare_dependencies
        
        if ~isfield(rocket, "engine");            rocket.engine            = struct();  end
        if ~isfield(rocket.engine, "oxidizer");   rocket.engine.oxidizer   = struct();  end
        if ~isfield(rocket.engine, "fuel_grain"); rocket.engine.fuel_grain = struct();  end
    
        
        rocket.engine.is_rigid_body            = true;
        rocket.engine.burn_time                = 1;
        rocket.engine.forces                   = struct();
        rocket.engine.thrust_force             = 1000;
        
        rocket.engine.oxidizer.is_rigid_body   = true;
        rocket.engine.fuel_grain.is_rigid_body = true;
        
        rocket.engine.oxidizer.mass            = 30;
        rocket.engine.fuel_grain.mass          = 4;

        rocket.engine.oxidizer.position        = [0;0;1.5];
        rocket.engine.fuel_grain.position      = [0;0;0.3];
    
    else
        
        rocket.oxidizer.mass                   = rocket.engine.oxidizer.mass      *(rocket.engine.burn_time - rocket.t)*(rocket.engine.burn_time > rocket.t)/rocket.engine.burn_time;
        rocket.engine.fuel_grain.mass          = rocket.engine.fuel_grain.mass    *(rocket.engine.burn_time - rocket.t)*(rocket.engine.burn_time > rocket.t)/rocket.engine.burn_time;

        
        if rocket.t < rocket.engine.burn_time; rocket.engine.forces.Thrust = force_vector([0;0;1]*rocket.engine.thrust_force, [0;0;0]); rocket.engine.active_burn = true;
        else;                                  rocket.engine.forces.Thrust = force_vector([0;0;0],                            [0;0;0]); rocket.engine.active_burn = false;
        end
    
    end
end

```



All models:
* Are state updates. They take the rocket-state as input, update it in some way, and feed it back out.
* Must declare their dependencies. A model must run without any models before it in the simulation stack, and must therefor declare it's own dependencies. The declare_dependencies.
* Models **can** be called from within other models, as is often the case with base_update_velocity or base_update_center_of_mass. If a model is called from within another model however, **make sure to call the models initiator as well** during model initiation. If this is not done it can lead to undefined behaviour.
* When declaring a substruct, check first for it's existence, as to not overwrite any parameters if another model has already initialized the substruct.


<br><br>

## base_HRAP_propulsion_model

base_HRAP_propulsion_model uses the output from [HRAP (Hybrid Rocket Analysis Program)](https://github.com/rnickel1/HRAP_Source) to provide both thrust-curve, fuel-mass and oxidizer-mass data.

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| rocket.engine.HRAP_file_path | string | filepath to the .csv file generated by HRAP |
| rocket.engine.oxidizer.mass | double | mass of oxidizer |
| rocket.engine.oxidizer.is_rigid_body | boolean | whether or not to apply phisics calculations, in this case mainly for center-of-mass calculations |
| rocket.engine.fuel_grain.mass | double | mass of fuel-grain |
| rocket.engine.fuel_grain.is_rigid_body | boolean | whether or not to apply phisics calculations, in this case mainly for center-of-mass calculations |

<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
| rocket.engine.forces.thrust | struct | [force-struct](#force_vector) describing the thrust  |
| rocket.engine.fuel_grain.mass | double | mass of fuel-grain |
| rocket.engine.oxidizer.mass | double | mass of oxidizer |

<br><br>

## base_aerodynamics_model

base_aerodynamics_model is MatRocket's proprietary aerodynamics-model, built for dynamic flight conditions. It handles rotation, energy dissipation and damping well, making it suitable for control-system workloads.

base_aerodynamics_model calls base_update_velocity internally.

base_aerodynamics_model is recursive, meaning it applies to all subcomponents that have the 

<br>

**Pre-processing flags:**
| input/property | type | description |
| ------ | ------ | ------ |
| ...component.independent_aerodynamics | boolean | flag to say that this component should have aerodynamics applied |
| ...component.aerodynamics_persistent_flag | boolean | the base_aerodynamics pre-proccessor removes a bunch of redundant geometry that is only used for aerodynamics calculations, after it has done its pre-processing stage. This flag tells the pre-processor to not remove/clean up the component |
| ...component.is_body | boolean | during pre-processing of the geometry, this affects whether the component gets drawn or not, and thereby if the geometry is included in the final model |
| ...component.is_rigid_body | boolean |  |

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| ...component.aerodynamics.moment_of_area | 3x3x4 double | area-moment tensor of the component |
| ...component.aerodynamics.length_scale | 3x1 double | characteristic length of each dimension of the rocket |
| ...component.aerodynamics.pressure_coefficient | 3x1 double | coefficient of drag for each of the 3 surfaces |
| ...component.aerodynamics.is_rigid_body | boolean | whether or not physics should be applied to the component. Used for aerodynamic-force calculations |

In addition to all inputs used by [base_update_velocity](#base_update_velocity)

<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
|  ...component.forces.LiftForce | struct | [force-struct](#force_vector) describing the lift on each surface. Position calculated based on moment |


<br><br>

## base_atmosphere_from_dataset_model

base_atmosphere_from_dataset_model allows for adding wind and atmosphere-data based on weather surveys, based on a .csv file. For downloadable data, see the [University of Wyoming Atmospheric Science Radiosonde Archive](https://weather.uwyo.edu/upperair/sounding.shtml).

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| rocket.position | 3x1 double | position of rocket in space, used for querying pressure, temperature etc at given altitude |
| rocket.atmosphere.dataset_path | string | path to the dataset used, .csv |

<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
| rocket.atmosphere.pressure | double | pressure at given altitude in Pa |
| rocket.atmosphere.temperature | double | temperature at given altitude in K |
| rocket.atmosphere.density | double | density at given altitude in kg/m3 |
| rocket.atmosphere.speed_of_sound | double | speed of sound at given altitude in m/s |
| rocket.atmosphere.wind_velocity | 3x1 double | wind velocity at given altitude in m/s |



<br><br>

## base_blender_update

base_blender_update uses the matrocketIO protocol to update a blender file live during simulation, useful for visualization of the flight both for rendering, debugging, controller work etc.

[NOTE!] base_blender_model was developed for blender 3.6. Other versions might break it.

<br>

**Blender-side:**

To import a geometry into blender, .glb is suggested as the best file-format for CAD -> Blender workflows. Import the geometry:

![image](./assets/Screenshot%202026-03-08%20003625.png)
![image](./assets/Screenshot%202026-03-08%20003639.png)

The easiest way to import a geometry that matches the partnames etc in MatRocket, is to use the .glb file generated alongside the json when calling [importSTEP](#importstep), it can be found in the folder adjacent to the original .step-file: 
![image](./assets/Screenshot%202026-03-08%20003717.png)
![image](./assets/Screenshot%202026-03-08%20003702.png)
![image](./assets/Screenshot%202026-03-08%20004417.png)

Then, in MatRocket, fill in the corresponding fields:

![image](./assets/Screenshot%202026-03-08%20004618.png)

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| rocket.blender_info.blenderclientpath | string | path to the python-script running inside blender, that runs the tcpclient |
| rocket.blender_info.render_each | boolean | option whether every single frame should be rendered, or whether MatRocket should wait for an acknowledgement from blender to send the next frame to keep the rendering realtime. If true, messages tend to be sent faster than blender can handle and blender might freeze |
| rocket.blender_info.target_object | string | the object inside blender that we're manipulating/writing to. In the above example this would be A01Mjollnirassembly2 |
| rocket.blender_info.blender_executable | string | path to the blender-executable used to run the .blend-file |
| rocket.blender_info.matrocketserver_name | string | does nothing, old code I have yet to remove |
| rocket.blender_info.blender_file | string | path to the actual .blend file we're rendering in |


<br><br>

## base_drag_coefficient_model

base_drag_coefficient_model is based on the thesis [Finding an Empirical Model for a
Rocket’s Drag Coefficients, A Comparative Analysis with OpenRocket](https://kth.diva-portal.org/smash/get/diva2:1881325/FULLTEXT01.pdf) by Maximillian Siez De Filippi. In it he built an impirical model for the drag coefficient of the Mjollnir rocket (AESIR KTH) based on CFD analysis.

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| rocket.wind_velocity_absolute | 3x1 double | relative wind velocity of the rocket |
| rocket.position | 3x1 double | position of rocket in space |
| rocket.aerodynamics.pressure_coefficient | 3x1 double | base pressure-coefficient, that is then offset via Filippi's model over mach-number, etc. Default is 1.0 |
| rocket.atmosphere.wind_velocity | 3x1 double | absolute wind velocity |
| rocket.atmosphere.speed_of_sound | double | speed of sound |

<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
| rocket.aerodynamics.pressure_coefficient(3) | double | pressure-coefficient resulting from mach-number, only applies to the z-face |


<br><br>

## base_dual_deploy_parachute_model

base_dual_deploy_parachute_model is a simple parachute model that assumes the drogue ejects at apogee, and the main chute deploys at some absolute altitude above the ground.

It simply assumes the force of the parachute is directly in line with the rocket's experienced relative wind, no side-to side contributions or damping due to the rocket's own oscillation.

base_update_velocity is called during base_dual_deploy_parachute_model.

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| rocket.velocity | 3x1 double | rocket velocity |
| rocket.attitude | 3x3 double | rocket attitude |
| rocket.forces | struct | [force-struct](#force_vector) |
| rocket.atmosphere.density | double | atmospheric density |
| rocket.atmosphere.wind_velocity | 3x1 double | wind velocity |
| rocket.drogue_chute.area | double | area of the drogue chute |
| rocket.drogue_chute.coefficient | double | drag coefficient of the drogue chute |
| rocket.drogue_chute.kill_rotation | boolean | whether rotation should be modelled during descent, faster but less accurate, as rocket body does contribute drag |
| rocket.drogue_chute.position | 3x1 double | position of drogue chute along the rocket body |
| rocket.main_chute.area | double | area of the main chute |
| rocket.main_chute.coefficient | double | drag coefficient of the main chute |
| rocket.main_chute.deployment_altitude | double | altitude for deploying the main chute |
| rocket.main_chute.kill_rotation | boolean | whether rotation should be modelled during descent, faster but less accurate, as rocket body does contribute drag |
| rocket.main_chute.position | 3x1 double | position of main chute along the rocket body |


<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
| rocket.forces.drogue_chute_drag | struct | [force-struct](#force_vector) describing the force the drogue chute is excerting on the rocket |
| rocket.forces.main_chute_drag | struct | [force-struct](#force_vector) describing the force the main chute is excerting on the rocket |


<br><br>

## base_equations_of_motion_model

base_equations_of_motion_model encapsulates the core newtonian equations of motion.

base_equations_of_motion_model calls both [base_update_forces](#base_update_forces) and [base_update_center_of_mass](#base_update_center_of_mass) internally.

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| rocket.attitude | 3x3 double | rocket attitude |
| rocket.rotation_rate | 3x1 | rockets rotation rate, right hand rule vector |
| rocket.position | 3x1 double | rockets position in space  |
| rocket.velocity | 3x1 double | rockets velocity |
| rocket.center_of_mass_summed | 3x1 double | total center of mass, including subcomponents & variable masses |
| rocket.mass_summed | double | total mass, including subcomponents and variable masses |
| rocket.forces_summed | struct | [force-struct](#force_vector), total force experienced by the entire rocket |

<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
| rocket.derivative("position") | 3x1 double | integrate velocity to get position |
| rocket.derivative("velocity") | 3x1 double | integrate acceleration to get velocity |
| rocket.derivative("angular_momentum") | 3x1 double | integrate moment to get angular momentum |
| rocket.derivative("attitude") | 3x3 | integrate the derivative of attitude to get attitude |

<br><br>

## base_gravity_model

base_gravity model applies the force of gravity downwards from the center-of-mass of the rocket.

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| rocket.attitude | 3x3 double | rockets attitude |
| rocket.enviroment.g | double | gravity constant |
| rocket.mass_summed | double | total mass of entire rocket, including subcomponents and variable masses |
| rocket.center_of_mass_summed | 3x1 double | total center of mass of entire rocket, including subcomponents and variable masses  |
| rocket.position | 3x1 double | rockets position in space |

<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
| rocket.forces.Gravity | struct | [force-struct](#force_vector) representing the force of gravity on the rocket |


<br><br>

## base_ground_interaction_model

base_ground_interaction_model detects when the rocket has impacted the ground, and stops it from sinking further into the ground.

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| rocket.position | 3x1 double | rockets position in space |
| rocket.velocity | 3x1 double | rockets velocity |
| rocket.acceleration | 3x1 double | rockets acceleration |

<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
| rocket.derivative("position") | 3x1 double | sets derivative to 0 |
| rocket.derivative("attitude") | 3x1 double | sets derivative to 0 |
| rocket.derivative("angular_momentum") | 3x1 double | sets derivative to 0 |


<br><br>

## base_manual_atmosphere_model

base_manual_atmosphere_model works much the same as [base_atmosphere_from_dataset_model](#base_atmosphere_from_dataset_model), querying pressure, temperature etc based on a .csv file, except wind-direction over altitude can be added manually, either in the UI or via scripting. For downloadable data, see the [University of Wyoming Atmospheric Science Radiosonde Archive](https://weather.uwyo.edu/upperair/sounding.shtml).


<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| rocket.position | 3x1 double | position of rocket in space, used for querying pressure, temperature etc at given altitude |
| rocket.atmosphere.dataset_path | string | path to the dataset used, .csv |
| rocket.atmosphere.wind_velocity_layers | cell | a json-encodable cell, with each element being a struct corresponding to a wind-layer, with fields "h": altitude of wind layer, "x": wind in x direction, "y": wind in y direction, and "z": wind in z direction |


<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
| rocket.atmosphere.pressure | double | pressure at given altitude in Pa |
| rocket.atmosphere.temperature | double | temperature at given altitude in K |
| rocket.atmosphere.density | double | density at given altitude in kg/m3 |
| rocket.atmosphere.speed_of_sound | double | speed of sound at given altitude in m/s |
| rocket.atmosphere.wind_velocity | 3x1 double | wind velocity at given altitude in m/s |



<br><br>

## base_hybrid_propulsion_model

base_hybrid_propulsion_model assumes a very simple hybrid engine with constant thrust throughout a given burn time, and linearly decreasing fuel and oxidizer mass.


<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| rocket.engine.is_rigid_body | boolean | whether to apply physics calculations, in this case to make [base_update_forces](#base_update_forces) and [base_update_center_of_mass](#base_update_center_of_mass) recognize the forces and the masses |
| rocket.engine.burn_time | double | burn duration of engine |
| rocket.engine.thrust_force | double | thrust force of engine |
| rocket.engine.oxidizer.is_rigid_body | boolean | whether to apply physics calculations, in this case to ensure the variable mass is included in the mass and center-of-mass calculations of the rocket |
| rocket.engine.fuel_grain.is_rigid_body | boolean | whether to apply physics calculations, in this case to ensure the variable mass is included in the mass and center-of-mass calculations of the rocket |
| rocket.engine.oxidizer.mass | double | starting mass of the oxidizer |
| rocket.engine.fuel_grain.mass | double | starting mass of the fuel |
| rocket.engine.oxidizer.position | 3x1 double | position of the oxidizer inside the rocket |
| rocket.engine.fuel_grain.position | 3x1 double | position of the fuel inside the rocket |

<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
| rocket.engine.forces.thrust | struct | [force-struct](#force_vector) describing the thrust  |
| rocket.engine.fuel_grain.mass | double | mass of fuel-grain |
| rocket.engine.oxidizer.mass | double | mass of oxidizer |



<br><br>

## base_single_deploy_parachute_model

base_single_deploy_parachute_model is a simple parachute model with single-deploy, ejecting at apogee.

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| rocket.velocity | 3x1 double | rockets velocity |
| rocket.attitude | 3x3 double | rockets attitude |
| rocket.atmosphere.density | double | density of atmosphere at given altitude |
| rocket.atmosphere.wind_velocity | 3x1 double | velocity of wind at given altitude |
| rocket.chute.area | double | area of the parachute |
| rocket.chute.coefficient | double | drag-coefficient of the parachute |
| rocket.chute.kill_rotation | boolean | whether or not to freeze any rotation after parachute ejection, speeds up the simulation as simulator can take larger timesteps but less accurate as rocket's body does contribute drag |
| rocket.chute.position | 3x1 double | position of chute along rockets body |

<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
| rocket.forces.chute_drag | struct | [force-struct](#force_vector) describing the drag from the parachute |


<br><br>

## base_update_center_of_mass

base_update_center_of_mass walks the rocket struct, and checks for all subcomponents with physics enabled, then calculates the total rocket mass and center-of-mass.

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| ...component.is_rigid_body | boolean | tells the model to perform the center-of-mass calculations for this component |
| ...component.position | 3x1 double | the location of the components mass is assumed to be the components position. If center-of-mass is translated relative to component, create a subcomponent representing the center-of-mass instead. Can be named "center_of_mass", "rigid_body" or something similar to distinguish it |
| ...component.attitude | 3x3 double | attitude of component |
| ...component.mass | 3x1 double | position of component relative to parent |

<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
| ...component.center_of_mass_summed | 3x1 double | total center of mass of th component including its subcomponents |
| ...component.mass_summed | double | total mass of th component including its subcomponents |


<br><br>

## base_update_forces

base_update_forces walks the rocket hierarchy and summs up all the forces/moments, to calculate the total force and moment on the body.

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| ...component.is_rigid_body | boolean | whether or not force-calculations/summing should be performed on this component |
| ...component.attitude | 3x3 double | attitude of component relative parent |
| ...component.position | 3x1 double | position of component relative parent |
| ...component.forces | struct | container for [forces](#force_vector) acting on component |
| ...component.moments | struct | container for [moments](#moment_vector) acting on component |

<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
| ...component.forces_summed | struct | [force-struct](#force_vector) containing the summed forces of the component and its subcomponents |
| ...component.moments_summed | struct | [moment-struct](#moment_vector) containing the summed moments of the component and its subcomponents |

<br><br>

## base_update_velocity

base_update_velocity calculates the relative wind-velocity for all the subcomponents with physics enabled, in their own respective basis. Especially important for aerodynamic surfaces, where the rocket's own rotation & the location of the part contributes to the wind experienced.

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| rocket.is_rigid_body | boolean | whether to do velocity transforms/calculations on the rocket |
| rocket.rigid_body | struct | subcomponent containing all the rigid-body parameters of the rocket like mass, moment of inertia etc  |
| rocket.rigid_body.position | 3x1 double | position of the center-of-mass of the rocket |
| rocket.rigid_body.mass | double | dry-mass of rocket (apart from other components with extra masses) |
| rocket.rigid_body.moment_of_inertia | 3x3 double | rockets moment of inertia |
| rocket.attitude | 3x3 double | rockets attitude |
| rocket.angular_momentum | 3x1 double | rockets angular momentum, in accordance with the right-hand rule |
| rocket.rotation_rate | 3x1 double | rockets rotation-rate vector, pointing along axis of rotation in accordance with right hand rule |
| rocket.position | 3x1 double | rockets position |
| rocket.velocity | 3x1 double | rockets velocity |
| rocket.atmosphere.wind_velocity | 3x1 double | base wind-velocity |
|  |  |  |
| ...component.is_rigid_body | boolean | whether or not to do velocity transforms/calculations on the component |
| ...component.position | 3x1 double | position of subcomponent relative to parent |
| ...component.attitude | 3x3 double | attitude of subcomponent relative to parent |
| ...component.rotation_rate | 3x1 double | rotation rate of subcomponent relative to parent |

<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
| rocket.rotation_rate | 3x1 double | rotation-rate of the rocket, calculated based on the angular momentum and the moment of inertia |
| ...component.rotation_rate_absolute | 3x1 double | absolute rotation-rate of the component, including the rotation of its parent |
| ...component.wind_velocity_absolute | 3x1 double | absolute wind velocity of the component, including the relative velocity and rotation of its parents |


<br><br><br>

# MatRocketCAD


This is the documentation for MatRocketCAD, an API for interfacing with CAD by importing and manipulating .step-files. 
![](./assets/cad.png)

<br><br>

## importSTEP

importSTEP is the main function used for importing step-functions into MATLAB. It uses FreeCAD as a converter from step to stl, and links the individual stl-files via json. It then imports the json and turns it into a nested struct. Due to the triangulation that has to happen between .step and .stl, it can take a while especially for complicated geometries, and it is therefor recommended to load the import into a .mat-file, and the .step then be re-imported when the CAD is changed.


Usage example:

```MATLAB
geometry = importSTEP("path/to/step/file.step")
```

Output:
```
geometry = 

  struct with fields:

                        position: [3×1 double]
                        attitude: [3×3 double]
           BB03Fuselagelowerhalf: [1×1 struct]
               AB01Gungnirengine: [1×1 struct]
           BB04Fuselageupperhalf: [1×1 struct]
                RecoveryAssembly: [1×1 struct]
       BB07NoseconeHasToBePointy: [1×1 struct]
                         BB05Fin: [1×1 struct]
                        BB05Fin2: [1×1 struct]
                        BB05Fin3: [1×1 struct]
                        BB05Fin4: [1×1 struct]
                         is_body: 1
        independent_aerodynamics: 1
    aerodynamics_persistent_flag: 0
                   is_rigid_body: 0

```

<br>

**Major inputs:**

| input/property | type | description | 
| -------- | ------- | ------- |
| **path** | string | path to the .step-file |

<br>

**Major outputs:**

| output/property | type | description | 
| -------- | ------- | ------- |
| **geometry** | [struct](https://se.mathworks.com/help/matlab/ref/struct.html) | nested struct with substructs representing either assemblies or parts |
| geometry.**position** | 1x3 double | position of rocket relative to origin |
| geometry.**attitude** | 3x3 double | orientation of rocket relative to origin |
| geometry.**mesh** | string | path to the mesh-part, as an stl-file |
| geometry.**mesh_scale** | 3x3 double | Matrix for deformation of the mesh, without affecting the children |
| geometry.**is_body** | boolean | Flag for draw_rocket, among others, to recognize that this struct has geometry |
| geometry.**component** | struct | substruct isomorphic with geometry, can in turn have position, attitude, and other substructs |



<br><br>

## draw_rocket

draw_rocket allows you to plot/drag the rocket geometry imported via [importSTEP](#importstep). 

Example usage:

```MATLAB

load("geometry_config.mat", "preabaked_rocket")

draw_rocket(gca, rocket_prebaked, "LineStyle", "none")

```
Output:
![](./assets/Screenshot%202026-02-25%20163744.png)

Example 2:

```MATLAB

load("geometry_config.mat", "preabaked_rocket")
ax = axes();
draw_rocket(ax, rocket_prebaked.AB01Thrustchamber, "LineStyle", "none")

```
Output:
![](./assets/Screenshot%202026-02-25%20163943.png)

<br>

**Major inputs:**

| input/property | type | description | 
| -------- | ------- | ------- |
| **ax** | [axes](https://se.mathworks.com/help/matlab/ref/axes.html) | MATLAB axes to draw the rocket in |
| **rocket_prebaked** | [struct](https://se.mathworks.com/help/matlab/ref/struct.html) | nested struct, output from [importSTEP]() or according to same spec |
| rocket_prebaked.**position** | 1x3 double | position of rocket relative to origin |
| rocket_prebaked.**attitude** | 3x3 double | orientation of rocket relative to origin |
| rocket_prebaked.**mesh** | string | path to the mesh-part, as an stl-file. Generated by the [importSTEP](#importstep) function |
| rocket_prebaked.**mesh_scale** | 3x3 double | Matrix for deformation of the mesh, without affecting the children |
| rocket_prebaked.**is_body** | boolean | Flag for draw_rocket, among others, to recognize that this struct has geometry |
| rocket_prebaked.**component** | struct | substruct isomorphic with rocket_prebaked, can in turn have position, attitude, and other substructs |
| **varargin** | [varargin](https://se.mathworks.com/help/matlab/ref/varargin.html) | see [trisuft properties](https://se.mathworks.com/help/matlab/ref/trisurf.html) |
| "ColorMode", @(comp, ~)rand(1,3) *(default)* | key-value pair: string, function-handle | a function that takes a substruct of rocket_prebaked and an optional string-address ("subcomponent.subcomponent2.subcomponent3") as input, and return a 1x3 double representing the part colour |
| "TraverseCondition", @(obj,~) true | key-value pair: string, function-handle | a function that takes in a substruct of rocket_prebaked, and an optional string-address("subcomponent.subcomponent2.subcomponent3") as input, and returns a boolean as output, describing whether or not the draw_rocket algorithm should continue down and draw the components children or not |
| "DrawCondition", @(obj,~) true | key-value pair: string, function-handle | a function that takes in a substruct of rocket_prebaked, and an optional string-address("subcomponent.subcomponent2.subcomponent3") as input, and returns a boolean as output, describing whether or not the draw_rocket algorithm should draw the component or not |

<br><br><br>

# MatRocketIO 

MatRocketIO is a communications protocol to link MatRocket together with other peripheries.

![](./assets/MatRocket_logo2%20IO%20transparent.png)

MatRocketIO's intended usage as of right now is to:
1. Provide a simple way to sync rocket states across the base simulation and any peripheries, be it hardware or interfacing with other software.
2. Be easy to use and set up, yet expandable and general if needed.
3. Be quick enough for HIL and realtime applications

As such, the MatRocketIO protocol has a set of ready made implmentations for the most common use-case, and this guide will differentiate between the core protocol, see [protocol specification](#protocol-specification), and it's implementations, see [Function documentation](#Function-documentation).

[Disclaimer!] This HIL protocol was initially deveoped for usage with Blender, and is as such meant to keep the entire rocket state synced. This is not the perfect HIL protocol for all applications. Some projects have used protobuf and other solutions in the past, and the performance of these solutions can make them worth sticking to in certain situations. Do not be afraid to make your own HIL implementations based on your application.



The basic protocol is divided up into multiple layers:
![image](./assets/layers.png)

* **API-layer:** This is is what is exposed to you in the matrocket enviroment, and acts as the primary interface.
* **Encoding-layer:** This layer takes care of queueing of messages, encoding and decoding the messages into raw bytes, attaching headers, etc. It's the middleman between the API-layer and the underlying protocol, if the underlying protocol is wished to be changed out, the encoding layer will likely have to be modified as well.
* **Transmit-layer:** This layer takes care of the actual transport, the default assumes a TCP server/client.

<br><br>

## remote_state (API-layer)

![image](./assets/state_delta.png)
remote_state is an abstraction layer to sync state across multiple nodes in a way that is safe for the MatRocket state. The fact that MatRocket's state is non-persistent means that any state update must be applied each timestep, and the solution to this is to have the remote node's state be persistent locally in the state-handler, that being the remote_state class. This allows for a protocol where state is only transmitted when something changes, saving on bandwidth. The protocol therefor sends deltas in the form of encoded json's, for more about the encoding step see [encoding_layer](#encoding_layer).


Example usage:

```MATLAB
s = remote_state()
```
Or:
```MATLAB
s = remote_state(
    "encoding_layer", encoding_layer())
```
Or:
```MATLAB
s = remote_state(
    "encoding_layer", encoding_layer(
    "transmit_layer", tcpclient('127.0.0.1', 50007) ))
```
See [encoding_layer](#encoding_layer) for more information on the default transmit_layer.

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| encoding_layer | encoding_layer | key-value pair, specifying the exact [encoding_layer](#encoding_layer) used. Useful for changing out the default encoding_layer to one with custom properties, for example if using a tcpclient instead of a tcpserver or similar |

<br>

**Methods:**

* [sync_local](#sync_local)
* [sync_remote](#sync_remote)
* [state_update](#state_update)

<br>

**properties:**

| input/property | type | description |
| ------ | ------ | ------ |
| encoding_layer | [encoding_layer](#encoding_layer) | underlying encoding layer |
| state_remote (hidden) | struct | local representation/persistent state of the remote state, updated each time sync_local is called, it then fetches the remote state and adds it to the local state |
 |state_local (hidden) | struct | local representation of the local state, updated each time sync_remote is called, it then updates the local state, and pushes the local state to the remote endpoint |


<br>

### sync_local
Example usage:

```MATLAB
%% Creating the endpoints
s1 = remote_state("encoding_layer", encoding_layer("transmit_layer", tcpserver('127.0.0.1', 50007)))
s2 = remote_state("encoding_layer", encoding_layer("transmit_layer", tcpclient('127.0.0.1', 50007)))


state1 = struct("hi", "bob");
s1.sync_remote(state1);
pause(6)
state2 = struct();
state2 = s2.sync_local(state2);

disp(state2)
```

Result:
```
    hi: 'bob'
```

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| state1 | struct / string / double / boolean (anything json-encodable) | the reference to be sent to the endpoint |

<br>

### sync_remote

Example usage:

```MATLAB
%% Creating the endpoints
s1 = remote_state("encoding_layer", encoding_layer("transmit_layer", tcpserver('127.0.0.1', 50007)))
s2 = remote_state("encoding_layer", encoding_layer("transmit_layer", tcpclient('127.0.0.1', 50007)))
pause(6)

state1 = struct("hi", "bob");
s1.sync_remote(state1);
pause(0.2)
state2 = struct();
state2 = s2.sync_local(state2);

disp(state2)
```

Result:
```
    hi: 'bob'
```

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| state2 | struct / string / double / boolean (anything json-encodable) | the state before syncing, if none is provided then sync_remote assumes an empty struct |

<br>

**Major outputs:**
| output/property | type | description |
| ------ | ------ | ------ |
| state2 | struct / string / double / boolean (anything json-encodable) | the state after syncing, uses [struct_append](#struct_append) |

<br>

### state_update

state_update is an internal function called by the underlying [encoding_layer](#encoding_layer), and is applied to each incoming message in the message_queue. See [parse_method](#parse_method).



<br><br>

## encoding_layer

Example usage:

```MATLAB
s = remote_state(
    "encoding_layer", encoding_layer())
```
Or:
```MATLAB
s = remote_state(
    "encoding_layer", encoding_layer(
    "transmit_layer", tcpclient('127.0.0.1', 50007) ))
```

<br>

**Major inputs:**
| input/property | type | description |
| ------ | ------ | ------ |
| transmit_layer | tcpserver/tcpclient/other communications protocol handler | underlying transmit method, tcpserver('127.0.0.1', 50007) by default |

<br>

**Methods:**

* [read](#read)
* [write](#write)
* [delete](#delete)
* [read_bytes](#read_bytes)
* [parse_buffer](#parse_buffer)
* [parse_input_queue](#parse_input_que)

<br>

**Properties:**

| property | type | description |
| ------ | ------ | ------ |
| input_queue | cell | messages waiting to be parsed by a parser |
| input_queue_is_empty | boolean | whether the input_queue is empty or not |
| input_buffer | byte-array | stores incoming bytes before any message delimiters have been identified, can include any number of encoded messages |
| [parse_method](#parse_method) | function-handle | function used to parse a message, takes the decoded message (a decoded json / nested struct) as argumet |
    

<br>

### read

[NOTE!] Not the standard entry-point when using MatRocketIO, but it's exposed for debugging purposes.

read tells the encoding_layer to read any incoming bytes, turn decode them into messages, and then parse the messages.

read is primarily meant to be called by other functions, if implementing a custom API-layer or similar, and is not meant to be used as is. 

Example-usage in the implementation of [sync_local](#sync_local):

```MATLAB

    function state = sync_local(self, state)
        arguments
            self
            state = struct();
        end
        self.encoding_layer.read()
        state = struct_append(state, self.state_remote);
    end

```

<br>

**Implementation:**

```MATLAB
    function read(self)
        self.read_bytes();
        self.parse_buffer();
        self.parse_input_queue();

    end
```

read wraps [read_bytes](#read_bytes), [parse_buffer](#parse_buffer) and [parse_input_queue](#parse_input_que) for more information on these methods.



<br>

### write

[NOTE!] Not the standard entry-point when using MatRocketIO, but it's exposed for debugging purposes.

write tells the encoding_layer to encode and then write all queued messages.

write is primarily meant to be called by other functions, if implementing a custom API-layer or similar, and is not meant to be used as is. 


Example-usage in the implementation of [sync_remote](#sync_remote):

```MATLAB

    function sync_remote(self, state)
        state            = rm_nonjsonfields(state);
        delta            = struct_difference(self.state_local, state);
        self.state_local = state;
        message          = delta;
        self.encoding_layer.write(message)
    
    end

```

See [struct_difference](#struct_difference) for more information.

<br>

**Major inputs:**

| input/property | type | description |
| ------ | ------ | ------ |
| message | struct / string / double / logical (anything json-encodable) | the raw message to be sent, before encoding |


<br>

### delete

deleter method, to ensure the underlying transmit-layer is closed correctly.


<br>

### read_bytes

[NOTE!] Not the standard entry-point when using MatRocketIO, but it's exposed for debugging purposes.

read_bytes reads the incoming bytes and adds them to the input-buffer, queueing them to be decoded and then parsed.

<br>

### parse_buffer

[NOTE!] Not the standard entry-point when using MatRocketIO, but it's exposed for debugging purposes.

Goes through the input_buffer and decodes it, turning the raw bytes into messages, that then get added to the input_queue.

<br>

### parse_input_queue

[NOTE!] Not the standard entry-point when using MatRocketIO, but it's exposed for debugging purposes.

Goes through the input_queue, and applies the parse_method property to all the messages in sequence.

<br>

### parse_method

This property is used after a message has been decoded and added to the [input_queue](#parse_input_queue), to then decide what to do with the message.

This can for example be assigned by an API/wrapper, as is the case with [state_update](#state_update).

<br>

**Specification:**

A parse_method must take the following form:

```MATLAB

function my_parse_method(message)
%% Do something with message
end

```

<br>

**Major inputs:**

| input/property | type | description |
| ------ | ------ | ------ |
| message | struct / string / double / logical (anything json-encodable) | incoming message |


<br>

Example usage in the implementation of state_update:

In this case the function is implemented as a class-method, allowing it to have a persistent state, and to allow other entry-points to access said state in a more user-friendly manner.

```MATLAB

    function state_update(self,message)
        state = message;
        self.state_remote = struct_append(self.state_remote, state);
    end

```



<br><br><br>

# Utils

<br><br>

## simulate_rocket

Main command for starting the MatRocket simulation, returns the simulated rocket over every timestep.

Example usage:

```MATLAB

load("initial_values_config.mat", "rocket_initial_values")

rocket_initial_values.ode_solver = @ode45;
rocket_initial_values.t_max      = 200;

rocket_results = simulate_rocket(rocket_initial_values);

save("initial_values_config_simulated.mat", "rocket_results", '-mat', 'append')

```

<br>

**Major inputs:**

| input/property | type | description | 
| -------- | ------- | ------- |
| rocket.ode_solver | function-handle | Any [ode-solver](https://se.mathworks.com/help/matlab/math/choose-an-ode-solver.html)  |
| rocket.t_max | double | simulation duration |
| rocket.models | cell | list of function-handles to the [models](#model-documentation) to be applied, aka the simulation-stack |

<br>

**Major outputs:**

| output/property | type | description |
| -------- | ------- | ------- |
| rocket_results | struct | Nested struct similar to rocket_initial_values, but with an extra dimension for each parameter, representing the different timesteps. |

<br><br>

## struct_append

A tool for adding nested structs on top of each other, with one struct taking priority over the other.

Example usage:

```MATLAB

%% Nested struct #1
struct1 = struct();
struct1.a = "hi";
struct1.b = "bob";


%% Nested struct #2
struct2 = struct();
struct2.a = "hello"
struct2.c = "world"


struct3 = struct_append(struct1, struct2)

```

Output:
```
struct3 = 

  struct with fields:

    a: "hello"
    b: "bob"
    c: "world"

```


<br>

**Major inputs:**

| input/property | type | description | 
| -------- | ------- | ------- |
| **struct1** | [struct](https://se.mathworks.com/help/matlab/ref/struct.html) | bottom-layer struct, gets overshadowed by struct2 |
| **struct2** | [struct](https://se.mathworks.com/help/matlab/ref/struct.html) | top-layer struct, overshadows struct1 |

<br>

**Major outputs:**

| output/property | type | description | 
| -------- | ------- | ------- |
| **struct3** | [struct](https://se.mathworks.com/help/matlab/ref/struct.html) | combined struct |


<br><br>

## struct_difference

A tool for checking the delta between nested structs, with one struct taking priority over the other. Useful for sending deltas, when you want to send the change of a state to an endpoint rather than the whole state.

Example usage:

```MATLAB

%% Nested struct #1
struct1 = struct();
struct1.a = "hi";
struct1.b = "bob";


%% Nested struct #2
struct2 = struct();
struct2.a = "hi"
struct2.c = "mom"


struct3 = struct_difference(struct1, struct2)

```

Output:
```
struct3 = 

  struct with fields:

    b: "bob"
    c: "mom"

```
In the above example "hi" is common for both structs, and is thus removed.

<br>

**Major inputs:**

| input/property | type | description | 
| -------- | ------- | ------- |
| **struct1** | [struct](https://se.mathworks.com/help/matlab/ref/struct.html) | bottom-layer struct, gets overshadowed by struct2 |
| **struct2** | [struct](https://se.mathworks.com/help/matlab/ref/struct.html) | top-layer struct, overshadows struct1 |

<br>

**Major outputs:**

| output/property | type | description | 
| -------- | ------- | ------- |
| **struct3** | [struct](https://se.mathworks.com/help/matlab/ref/struct.html) | combined struct |


<br><br>

## setfield_safe

Essentially the same as [setfield](https://se.mathworks.com/help/matlab/ref/setfield.html), but with safe handling of cases where the subfield doesn't exist. setfield_safe creates empty fields if the field does not exist in the original struct.

Example usage:

```MATLAB

s = struct();
fields = {"hi", "bob"};
value = 2;
s = setfield_safe(s, fields, value)

```

Output:
```
s = 

  struct with fields:

    hi: [1×1 struct]

>> s.hi

ans = 

  struct with fields:

    bob: 2


```

<br>

**Major inputs:**

| input/property | type | description | 
| -------- | ------- | ------- |
| **s** | [struct](https://se.mathworks.com/help/matlab/ref/struct.html) | nested struct |
| **fields** | [cell](https://se.mathworks.com/help/matlab/ref/cell.html) | cell array with strings, describing the path to the deepest field in the struct |
| **value** | any | value of the field |

<br>

**Major outputs:**

| output/property | type | description | 
| -------- | ------- | ------- |
| **s** | [struct](https://se.mathworks.com/help/matlab/ref/struct.html) | nested struct with subsequent fields set |

<br><br>

## struct_printout

Utility for printing our large nested structures, including their hierarchy.

Example usage:

```MATLAB

struct_printout(rocket)

```

Output:
```
struct with fields:
 ├───────────────────── position:  
 ├───────────────────── attitude:  
 ├────────────────────── is_body:  
 ├───── independent_aerodynamics:  
 ├─ aerodynamics_persistent_flag:  
 ├──────────────── is_rigid_body:  
 ├─────────────────────── models:  
 ├─────────────────── derivative:  
 ╞═══════════════════  atmosphere
 │                            ├── dataset_path:  
 │                            ├─ wind_velocity:  
 │                            ├─ is_rigid_body:  
 │                            ├─────── density:  
 │                            ├────── pressure:  
 │                            ├─── temperature:  
 │                            └ speed_of_sound:  
 ╞═════════════════  aerodynamics
 │                            ├──────── moment_of_area:  
 │                            ├────────── surface_area:  
 │                            ├────────── length_scale:  
 │                            ├── pressure_coefficient:  
 │                            ├── friction_coefficient:  
 │                            ├───────── is_rigid_body:  
 │                            ├────────────── position:  
 │                            ├────────────── attitude:  
 │                            ├────────────────── mass:  
 │                            ├───────── 
 
 
 
 
 
 ...


```

<br>

**Major inputs:**

| input/property | type | description | 
| -------- | ------- | ------- |
| **rocket** | [struct](https://se.mathworks.com/help/matlab/ref/struct.html) | nested struct |

<br><br>

## force_vector

Takes in a position and a vector, and packages it as a struct.

Example usage:

```MATLAB

position = [0;0;0];
vector   = [0;0;4e3];
rocket.engine.forces.thrust = force_vector(vector, position);

```
<br>

**Major inputs:**

| input/property | type | description | 
| -------- | ------- | ------- |
| position | 3x1 double | position of force-vector |
| vector | 3x1 double | direction of force-vector |

<br>

**Major outputs:**

| output/property | type | description | 
| -------- | ------- | ------- |
| force | struct | struct containing position and vector |

<br><br>

## moment_vector

Takes in a position and a vector, and packages it as a struct.

Example usage:

```MATLAB

position = [0;0;0];
vector   = rand(3,1);
rocket.engine.moments.vibration = moment_vector(vector, position);

```
<br>

### Major inputs:

| input/property | type | description | 
| -------- | ------- | ------- |
| position | 3x1 double | position of moment-vector (right-hand rule) |
| vector | 3x1 double | direction of moment-vector (right-hand rule) |

<br>

### Major outputs:

| output/property | type | description | 
| -------- | ------- | ------- |
| moment | struct | struct containing position and vector |