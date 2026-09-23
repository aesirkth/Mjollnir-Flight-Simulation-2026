function rocket = base_update_velocity(rocket, declare_dependencies)

    
    if declare_dependencies
    
        %% Rigid-body model 6DoF
        if ~isfield(rocket, "rigid_body"); rocket.rigid_body = struct(); end
    
        rocket.rigid_body.is_rigid_body                      = true;
        rocket.rigid_body.position                           = [0; 0; 800.706]*1e-3;
        rocket.rigid_body.mass                               =  10;
        rocket.rigid_body.moment_of_inertia                  = [ 1.681e9,  -5391.751,  5909.685;
                                                                -5391.751,  1.681e9,   6011.009;
                                                                 5909.685,  6011.009,  1.849e7  ]*1e-9;
    
        rocket.angular_momentum                              = zeros(3,1);
        rocket.velocity                                      = zeros(3,1); 
        
        if ~isfield(rocket, "atmosphere");rocket.atmosphere  = struct(); end
        rocket.atmosphere.wind_velocity                      = [0;0;0];
    
        rocket                                               = recursive_setfield(rocket, "is_rigid_body", @check_if_rigid_body_children );
        rocket                                               = base_update_center_of_mass(rocket, true);
        rocket                                               = update_velocity_initiator(rocket);
        
    else
    
        rocket                         = base_update_center_of_mass(rocket, false);

        rocket.wind_velocity_absolute  = (rocket.atmosphere.wind_velocity - rocket.velocity) - cross(rocket.rotation_rate, -rocket.center_of_mass_summed); % Wind velocity is at rocket origin, velocity is assumed to be at center of mass, for all aerodynamic applications
        rocket.rotation_rate           = (rocket.attitude*rocket.rigid_body.moment_of_inertia*(rocket.attitude'))\rocket.angular_momentum; 
        rocket.rotation_rate_absolute  = rocket.rotation_rate;
        
        rocket                         = update_velocity_internal(rocket);
        
    
    end
    
    
    function obj = update_velocity_internal(obj)
        
        if ~isfield(obj, 'rotation_rate_absolute'); obj.rotation_rate_absolute = obj.rotation_rate;    end
        if ~isfield(obj, 'wind_velocity_absolute'); obj.wind_velocity_absolute = zeros(3,1);           end
        
        child_names = fieldnames(obj);
        
        for child_index = 1:numel(child_names)
            child_name = child_names{child_index};
            if  is_rigid_body(obj.(child_name))
                
                obj.(child_name).rotation_rate_absolute    = (obj.attitude')*obj.rotation_rate_absolute + obj.(child_name).rotation_rate;
                obj.(child_name).wind_velocity_absolute    = (obj.attitude')*obj.wind_velocity_absolute - cross((obj.attitude')*obj.rotation_rate_absolute, obj.(child_name).position);
                obj.(child_name)                           = update_velocity_internal(obj.(child_name));
                
            end
        end
        
    end
    
   
    
    
    
    
    
    
    function obj = update_velocity_initiator(obj)
    
        if ~isfield(obj, 'position');      obj.position      = zeros(3,1); end
        if ~isfield(obj, 'attitude');      obj.attitude      = eye(3,3);   end
        if ~isfield(obj, 'rotation_rate'); obj.rotation_rate = zeros(3,1); end
        
        child_names = fieldnames(obj);
        
        for child_index = 1:numel(child_names)
            child_name = child_names{child_index};
            if is_rigid_body(obj.(child_name))
                obj.(child_name) = update_velocity_initiator(obj.(child_name));
            end
        end  
       
    
    end
    
    
    function tf = check_if_rigid_body_children(variable)
        tf = 0;
        if isfield(variable, 'is_rigid_body')
            tf = variable.is_rigid_body;
        end
        
        child_names = fieldnames(variable);
        child_index = 1;
        while tf == 0
        
            child_name = child_names{child_index};
            if isstruct(variable.(child_name))
            tf = tf + check_if_rigid_body_children(variable.(child_name));
            end
    
        child_index = child_index + 1;
        if child_index > numel(child_names); break; end
        end
    
    
        tf = tf > 0;
    
    end

end
