function rocket = mjollnir_propulsion_model(rocket, declare_dependencies)

    if declare_dependencies
        
        if ~isfield(rocket, "engine");            rocket.engine            = struct();  end
        if ~isfield(rocket.engine, "oxidizer");   rocket.engine.oxidizer   = struct();  end
        if ~isfield(rocket.engine, "fuel_grain"); rocket.engine.fuel_grain = struct();  end

        data = load("MJ_FullThrust_18C.mat").MJ_FullThrust_18C;

        data = data(2:end, :);

        % NEED MAX TIME
        rocket.thrustT = griddedInterpolant(data(:,1), data(:,2), "makima");
        rocket.N20_massT = griddedInterpolant(data(:,1), data(:,4), "makima");
        rocket.Paraffin_massT = griddedInterpolant(data(:,1), data(:,5), "makima");


        rocket.engine.is_rigid_body = true;
        rocket.engine.burn_time = 20;
        rocket.engine.oxidizer.is_rigid_body = true;
        rocket.engine.fuel_grain.is_rigid_body = true;

        rocket.engine.oxidizer.mass = 24;
        rocket.engine.fuel_grain.mass = 4.3;

        rocket.engine.oxidizer.position = rocket.mjollnir_oxidizer_position;
        rocket.engine.fuel_grain.position = rocket.mjollnir_fuelgrain_position;

    else
        rocket.engine.oxidizer.mass = rocket.N20_massT(rocket.t);
        rocket.engine.fuel_grain.mass = rocket.Paraffin_massT(rocket.t);

        if rocket.t < rocket.engine.burn_time 
            rocket.engine.forces.thrust = force_vector([0;0;1]*rocket.thrustT(rocket.t), [0;0;0]); 
            rocket.engine.active_burn = true;

        else                      
            rocket.engine.forces.thrust = force_vector([0;0;0], [0;0;0]); 
            rocket.engine.active_burn = false;
        end
    end