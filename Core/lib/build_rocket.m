function initial_value   = bake_rocket(rocket_config)

rocket                   = rocket_config;
rocket.derivative        = containers.Map();

%% Applying the rockets own models
for i = 1:numel(rocket.models)    
apply_model = rocket.models{i};
rocket      = apply_model(rocket);
end

struct_printout(rocket.AB01Gungnirengine)
struct_printout(rocket_config.AB01Gungnirengine)
initial_value = struct_delta(rocket, rocket_config);
struct_printout(initial_value.AB01Gungnirengine)

end



function delta = struct_delta(struct1, struct2)

    delta      = struct();

    child_names = fieldnames(struct1);
    for child_index = 1:numel(child_names)
        child_name = child_names{child_index};
        
        % one is missing
        if ~isfield(struct2, child_name)
        delta.(child_name) = struct1.(child_name);
    
        % one is not a struct
        elseif ~isequal(class(struct1.(child_name)), "struct") | ~isequal(class(struct2.(child_name)), "struct")
        if ~isequal(struct1.(child_name), struct2.(child_name))
        delta.(child_name) = struct2.(child_name);
        end
        
        % both are structs
        else
        child_delta = struct_delta(struct1.(child_name), struct2.(child_name));
        if numel(fieldnames(child_delta)) > 0
        delta.(child_name) = child_delta;
        end
        end
    end



end




