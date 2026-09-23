function delta = struct_difference(struct1, struct2)

    delta      = struct();

    child_names = fieldnames(struct1);
    for child_index = 1:numel(child_names)
        child_name = child_names{child_index};

  
            
        % one is missing
        if ~isfield(struct2, child_name)
            delta.(child_name) = struct1.(child_name);
        
            % one is not a struct
        elseif ~isstruct(struct1.(child_name)) | ~isstruct(struct2.(child_name))
            if ~isequal(struct1.(child_name), struct2.(child_name))
                delta.(child_name) = struct2.(child_name);
            end
            
        % both are structs
        else
            if isscalar(struct1.(child_name))
                child_delta = struct_difference(struct1.(child_name), struct2.(child_name));
                if numel(fieldnames(child_delta)) > 0
                    delta.(child_name) = child_delta;
                end
            end
        end

    end





    child_names = fieldnames(struct2);
    for child_index = 1:numel(child_names)
        child_name = child_names{child_index};
        % one is missing
        if ~isfield(struct1, child_name)
            delta.(child_name) = struct2.(child_name);
        end
 
    end

end




