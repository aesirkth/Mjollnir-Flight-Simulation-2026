function obj = update_transforms(obj)


    
    if ~isfield(obj, "position"); obj.position = [0;0;0]; end
    if ~isfield(obj, "attitude"); obj.attitude = eye(3);  end
    if ~isfield(obj, 'position_global'); obj.position_global = obj.position;           end
    if ~isfield(obj, 'attitude_global'); obj.attitude_global = obj.attitude;           end

    
    obj.position_global = obj.position;
    obj.attitude_global = obj.attitude;
    obj = update_transform_internal(obj);
    
    
    


    function obj = update_transform_internal(obj)
    
        if is_body(obj)
            if ~isfield(obj, 'position');        obj.position = zeros(3,1);                    end
            if ~isfield(obj, 'attitude');        obj.attitude = eye(3,3)  ;                    end
            if ~isfield(obj, 'position_global'); obj.position_global = obj.position;           end
            if ~isfield(obj, 'attitude_global'); obj.attitude_global = obj.attitude;           end
        end
        
        
        
        child_names = fieldnames(obj);
        
        for child_index = 1:numel(child_names)
            child_name = child_names{child_index};
            if  is_body(obj.(child_name))
                if ~isfield(obj.(child_name), 'position'); obj.(child_name).position = zeros(3,1); end
                if ~isfield(obj.(child_name), 'attitude'); obj.(child_name).attitude = eye(3,3)  ; end
                obj.(child_name).position_global = obj.position_global  + obj.attitude_global *obj.(child_name).position;
                obj.(child_name).attitude_global = obj.attitude_global * obj.(child_name).attitude;
                obj.(child_name) = update_transform_internal(obj.(child_name));
            end
        end
    
    end
end
