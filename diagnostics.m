results_path = fullfile(fileparts(mfilename('fullpath')), ...
    'initial_values_config_simulated.mat');
initial_values_config_simulated = load(results_path, 'rocket_results');
results = initial_values_config_simulated.rocket_results;

t = reshape(results.t, 1, []);

figure
tiledlayout(3, 2);

% Altitude
position_z = reshape(results.position(3, :), 1, []);

nexttile
plot(t, position_z)
title("Altitude")

% Rotation rate
rotation_rate_x = reshape(results.rotation_rate(1, :), 1, []);
rotation_rate_y = reshape(results.rotation_rate(2, :), 1, []);
rotation_rate_z = reshape(results.rotation_rate(3, :), 1, []);

nexttile
plot(t, rotation_rate_x);
title("Rotation rate")
hold on
plot(t, rotation_rate_y);
plot(t, rotation_rate_z);
legend("x", "y", "z")
hold off

% Total mass
total_mass = reshape(results.mass_summed, 1, []);

nexttile
plot(t, total_mass);
title("Total mass");

% Center of mass
center_of_mass = reshape(results.center_of_mass_summed(3, :), 1, []);

nexttile
plot(t, center_of_mass);
title("Center of mass, z")