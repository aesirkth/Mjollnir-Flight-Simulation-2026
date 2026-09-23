function rocket = base_update_forces(rocket, declare_dependencies)

    
    if declare_dependencies
        
        rocket = update_forces_initiator(rocket);
    else
    
        rocket = update_forces_internal(rocket);
        
    end

    
    
    function obj = update_forces_internal(obj)

        obj.force_summed  = force_vector( [0;0;0],[0;0;0]);
        obj.moment_summed = moment_vector([0;0;0],[0;0;0]);
        
        
        if isfield(obj, 'forces')
            force_names     = fieldnames(obj.forces);
            for force_index = 1:numel(force_names)
                
                force_name               = force_names{force_index};
                
                obj.force_summed .vector = obj.force_summed .vector +                                         obj.forces.(force_name).vector;
                obj.moment_summed.vector = obj.moment_summed.vector + cross(obj.forces.(force_name).position, obj.forces.(force_name).vector);
            end
        end
        
        if isfield(obj, 'moments')
            moment_names = fieldnames(obj.moments);
            for moment_index = 1:numel(moment_names)
                moment_name = moment_names{moment_index};
                
                obj.moment_summed.vector = obj.moment_summed.vector + obj.moments.(moment_name).vector;
                
            end
        end
        
        
        
        child_names = fieldnames(obj);
        
        for child_index = 1:numel(child_names)
            child_name = child_names{child_index};
            if is_rigid_body(obj.(child_name))
                obj.(child_name)          = update_forces_internal(obj.(child_name));
                obj.force_summed          = force_vector( obj.force_summed .vector + obj.(child_name).attitude*obj.(child_name).force_summed .vector, [0;0;0]);
                obj.moment_summed         = moment_vector(obj.moment_summed.vector + obj.(child_name).attitude*obj.(child_name).moment_summed.vector + cross(obj.(child_name).position, obj.(child_name).attitude*obj.(child_name).force_summed.vector), [0;0;0]);
            end
            
        end
        
    end


end




function obj = update_forces_initiator(obj)
    
    if is_rigid_body(obj)            
        if ~isfield(obj, 'position'); obj.position = zeros(3,1); end
        if ~isfield(obj, 'attitude'); obj.attitude = eye(3,3);   end            
        child_names = fieldnames(obj);
            
            for child_index = 1:numel(child_names)
                child_name = child_names{child_index};
                obj.(child_name)          = update_forces_initiator(obj.(child_name));
            end
    
    end
end




