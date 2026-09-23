function struct1 = struct_append(struct1, struct2)
    % add struct2 to struct1
    child_names = fieldnames(struct2);
    for child_index = 1:numel(child_names)
        child_name = child_names{child_index};
        
        if isfield(struct2, child_name)
        if    isstruct(struct2.(child_name)) && isscalar(struct2.(child_name))
            if ~isfield(struct1, child_name); struct1.(child_name) = struct();end
                                              struct1.(child_name) = struct_append(struct1.(child_name), struct2.(child_name));
        else;                                 struct1.(child_name) = struct2.(child_name);
        end
        end
    end
end
