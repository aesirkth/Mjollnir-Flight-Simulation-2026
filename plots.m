results_path = fullfile(fileparts(mfilename('fullpath')), ...
    'initial_values_config_simulated.mat');
initial_values_config_simulated = load(results_path, 'rocket_results');
results = initial_values_config_simulated.rocket_results;

position_z = reshape(results.position(3, :), 1, []);
altitude_max = max(position_z);

rotation_rate_x = reshape(results.rotation_rate(1, :), 1, []);
rotation_rate_y = reshape(results.rotation_rate(2, :), 1, []);
rotation_rate_z = reshape(results.rotation_rate(3, :), 1, []);
rotation_rate_x_max = max(rotation_rate_x);
rotation_rate_y_max = max(rotation_rate_y);
rotation_rate_z_max = max(rotation_rate_z);

disp("Maximum altitude:")
disp(altitude_max)

disp("Rotation rate:")
disp("x: " + rotation_rate_x_max);
disp("y: " + rotation_rate_y_max);
disp("z: " + rotation_rate_z_max);