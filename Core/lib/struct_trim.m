function struct1 = struct_trim(struct1, struct2)
    
    child_names  = fieldnames(struct1);
    child_names2 = fieldnames(struct2);

    for child_index = 1:numel(child_names)
        child_name = child_names{child_index};

        if cellsum(cellfun(@(el) isequal(string(el), string(child_name)), child_names2, "UniformOutput",false)) == 0
            struct1              = rmfield(struct1, child_name);
        elseif isstruct(struct1.(child_name)) && isstruct(struct2.(child_name)) && isscalar(struct1.(child_name)) && isscalar(struct2.(child_name))
            struct1.(child_name) = struct_trim(struct1.(child_name), struct2.(child_name));
        end

    end

end