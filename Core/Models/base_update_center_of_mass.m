function rocket = base_update_center_of_mass(rocket, declare_dependencies)

    
    if declare_dependencies
    
        rocket = update_center_of_mass_initiator(rocket);
        if ~isfield(rocket, "rigid_body"); rocket.rigid_body = struct(); end
    
    else
    
        
        
        rocket = update_center_of_mass_internal(rocket);
        rocket.center_of_mass_summed = rocket.center_of_mass_summed - rocket.position;
        
    end
    
    
    
    function obj = update_center_of_mass_internal(obj)
        
        if is_rigid_body(obj)

            obj.mass_summed           = obj.mass;
            obj.center_of_mass_summed = obj.position;
            
            
            child_names = fieldnames(obj);
            
            for child_index = 1:numel(child_names)
                child_name = child_names{child_index};
                if  is_rigid_body(obj.(child_name))
                    
                    
                    obj.(child_name)          = update_center_of_mass_internal(obj.(child_name));
                    
                    obj.center_of_mass_summed = (obj.center_of_mass_summed*obj.mass_summed + (obj.position + obj.attitude*obj.(child_name).center_of_mass_summed)*obj.(child_name).mass_summed) / ...
                                                                         ((obj.mass_summed +                                                                      obj.(child_name).mass_summed) + ...
                                                                         ((obj.mass_summed +                                                                      obj.(child_name).mass_summed) == 0) );
                    
                    obj.mass_summed           =                            obj.mass_summed +                                                                      obj.(child_name).mass_summed;
                    
                    
                end
            end
        end
    end






    function obj = update_center_of_mass_initiator(obj)
        
        if is_rigid_body(obj)
            if ~isfield(obj, 'position'); obj.position = zeros(3,1); end
            if ~isfield(obj, 'attitude'); obj.attitude = eye(3,3);   end
            if ~isfield(obj, 'mass');     obj.mass     = 0;          end
            
            
            child_names = fieldnames(obj);
            
            for child_index = 1:numel(child_names)
                child_name = child_names{child_index};
                if  is_rigid_body(obj.(child_name))
                    
                    obj.(child_name)          = update_center_of_mass_initiator(obj.(child_name));
                    
                end
            end
        end
    end




end