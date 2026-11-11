%setup_dir = fileparts(mfilename("fullpath"));
%step_path = fullfile(setup_dir, "RocketSource", "AM_00 Mjollnir Full CAD.step");
%rocket_default_values = importSTEP(step_path);

save("geometry_config.mat", "rocket_default_values", '-mat', '-append')
