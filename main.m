%% Setup
project_root = fileparts(mfilename('fullpath'));
addpath(genpath(fullfile(project_root, 'Core')));
addpath(genpath(fullfile(project_root, 'RocketSource/Mjollnir')));

geometry_config = load(fullfile(project_root, 'geometry_config.mat'), ...
    'rocket_default_values');
rocket_prebaked = geometry_config.rocket_default_values;
[rocket_prebaked, mesh_directories] = use_mesh_filenames(rocket_prebaked);
mesh_directories = unique(mesh_directories);
for mesh_directory_index = 1:numel(mesh_directories)
    addpath(mesh_directories(mesh_directory_index));
end
CAD = struct();

%% Models
rocket_prebaked.models = { ...
    @mjollnir_mass_mapping, ...
    @base_atmosphere_from_dataset_model, ...
    @base_aerodynamics_model, ...
    @base_drag_coefficient_model, ...
    @mjollnir_propulsion_model, ...
    @base_gravity_model, ...
    @base_dual_deploy_parachute_model, ...
    @base_equations_of_motion_model, ...
    @base_ground_interaction_model, ...
    @mjollnir_mass_model ...
};

rocket_initial_values = bake_rocket(rocket_prebaked, true);

disp("Total massa, fueled:")
disp(rocket_initial_values.mass_summed)

disp("Center of mass, fueled:")
disp(rocket_initial_values.center_of_mass_summed)

%% Settings.
rocket_initial_values.ode_solver = @ode45;
rocket_initial_values.t_max = 60;

%% Simulation
rocket_results = simulate_rocket(rocket_initial_values);
results_path = fullfile(project_root, 'initial_values_config_simulated.mat');
save(results_path, 'rocket_initial_values', 'rocket_results', '-v7.3');

disp("Extra nosecone mass: 0kg")

plots

function [obj, mesh_directories] = use_mesh_filenames(obj)
    mesh_directories = strings(0,1);
    if isfield(obj, 'mesh')
        [~, name, extension] = fileparts(string(obj.mesh));
        filename = name + extension;

        % Letar upp filen var den än ligger i projektmappen
        matches = dir(fullfile(pwd, '**', filename));
        if isempty(matches)
            error('MatRocket:MeshFileNotFound', 'Hittade inte STL-filen någonstans i projektet: %s', filename);
        end

        obj.mesh = filename;
        mesh_directories(end+1,1) = string(matches(1).folder);
    end
    child_names = fieldnames(obj);
    for child_index = 1:numel(child_names)
        child_name = child_names{child_index};
        if isstruct(obj.(child_name))
            [obj.(child_name), child_directories] = use_mesh_filenames(obj.(child_name));
            mesh_directories = [mesh_directories; child_directories]; %#ok<AGROW>
        end
    end
end
