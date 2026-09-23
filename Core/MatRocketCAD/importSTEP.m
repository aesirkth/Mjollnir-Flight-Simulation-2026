function obj = importSTEP(filepath)

outpath     = step2json(filepath);
obj         = jsondecode(fileread(outpath+"hierarchy.json"));


child = fieldnames(obj);
obj = obj.(child{1});

obj = full_stl_path(obj);
obj = recursive_set(obj, "is_body", true);
obj = recursive_set(obj, "independent_aerodynamics", false);
obj = recursive_set(obj, "aerodynamics_persistent_flag", false);
obj = recursive_set(obj, "is_rigid_body", false);

obj = recursive_set(obj, "mesh_scale", eye(3), @(obj) isfield(obj, "mesh"));
obj.independent_aerodynamics = true;


    function obj = full_stl_path(obj)
    if isfield(obj, "mesh")
    obj.mesh = string(replace(filepath, ".step", "/"))+string(obj.mesh);
    end
    child_names = fieldnames(obj);
    for child_index = 1:numel(child_names)
    child_name = child_names{child_index};
        if isequal(class(obj.(child_name)), 'struct')
        obj.(child_name) = full_stl_path(obj.(child_name));
        end

    end
    end

end