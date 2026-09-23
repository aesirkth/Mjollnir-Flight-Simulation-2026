function rocket = base_hybrid_propulsion_model(rocket, declare_dependencies)
    
    if declare_dependencies
        
        if ~isfield(rocket, "engine");            rocket.engine            = struct();  end
        if ~isfield(rocket.engine, "oxidizer");   rocket.engine.oxidizer   = struct();  end
        if ~isfield(rocket.engine, "fuel_grain"); rocket.engine.fuel_grain = struct();  end
    
        
        rocket.engine.is_rigid_body            = true;
        rocket.engine.burn_time                = 14;
        rocket.engine.forces                   = struct();
        rocket.engine.thrust_force             = 4000;
        
        rocket.engine.oxidizer.is_rigid_body   = true;
        rocket.engine.fuel_grain.is_rigid_body = true;
        
        rocket.engine.oxidizer.mass            = 30;
        rocket.engine.fuel_grain.mass          = 4;

        rocket.engine.oxidizer.position        = [0;0;1.5];
        rocket.engine.fuel_grain.position      = [0;0;0.3];
    
    else
        
        rocket.engine.oxidizer.mass                   = rocket.engine.oxidizer.mass      *(rocket.engine.burn_time - rocket.t)*(rocket.engine.burn_time > rocket.t)/rocket.engine.burn_time;
        rocket.engine.fuel_grain.mass          = rocket.engine.fuel_grain.mass    *(rocket.engine.burn_time - rocket.t)*(rocket.engine.burn_time > rocket.t)/rocket.engine.burn_time;

        
        if rocket.t < rocket.engine.burn_time; rocket.engine.forces.thrust = force_vector([0;0;1]*rocket.engine.thrust_force, [0;0;0]); rocket.engine.active_burn = true;
        else;                                  rocket.engine.forces.thrust = force_vector([0;0;0],                            [0;0;0]); rocket.engine.active_burn = false;
        end
    
    end
end