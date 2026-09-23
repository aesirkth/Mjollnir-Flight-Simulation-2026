function initial_value   = bake_rocket(rocket_config, init)

if ~exist("init" ,"var"); init = true; end

clear functions


initial_value            = rocket_config;
initial_value.derivative = containers.Map();

%% Applying the rockets own models

for i = 1:numel(initial_value.models)    
apply_model        = initial_value.models{i};
initial_value      = apply_model(initial_value, init);
end


end
