function rocket = base_dual_deploy_parachute_model(rocket, declare_dependencies)
% Dual deploy chute, with drogue deployed at apogee, and main deployed at
% set altitude


persistent drogue_chute_ejected
persistent main_chute_ejected

if declare_dependencies

rocket.velocity                       = [0;0;0];
rocket.attitude                       = eye(3);
rocket.forces                         = struct();

if ~isfield(rocket, "atmosphere"); rocket.atmosphere = struct(); end
rocket.atmosphere.density             = 1;
rocket.atmosphere.wind_velocity       = [0;0;0];
if ~isfield(rocket, "drogue_chute"); rocket.drogue_chute = struct(); end
rocket.drogue_chute.area              = 1;
rocket.drogue_chute.coefficient       = 1;
rocket.drogue_chute.kill_rotation     = false;
rocket.drogue_chute.position          = [0;0;1];
if ~isfield(rocket, "main_chute"); rocket.main_chute = struct(); end
rocket.main_chute.area                = 1;
rocket.main_chute.coefficient         = 1;
rocket.main_chute.deployment_altitude = 300;
rocket.main_chute.kill_rotation       = false;
rocket.main_chute.position            = [0;0;1];
rocket                                = base_update_velocity(rocket, true);

else





if isempty(drogue_chute_ejected); drogue_chute_ejected = false; end
if isempty(main_chute_ejected);   main_chute_ejected   = false; end


if ~drogue_chute_ejected && rocket.velocity(3) < 0 && rocket.position(3) > 100; drogue_chute_ejected = true; disp("drogue chute");end


if drogue_chute_ejected
    
    rocket                           = base_update_velocity(rocket, false);
    drag_magnitude                   = 0.5*rocket.atmosphere.density*rocket.drogue_chute.area*norm(rocket.velocity - rocket.atmosphere.wind_velocity)^2*rocket.drogue_chute.coefficient; %calulate drag using Cd and reference area assigned in my_rocket
    drag_direction                   = -normalize(rocket.velocity - rocket.atmosphere.wind_velocity); %direction of the force is assumed to be equal to that of the rocket's velocity
    drag                             = drag_magnitude*drag_direction;
    rocket.forces.drogue_chute_drag  = force_vector((rocket.attitude')*drag, rocket.drogue_chute.position);
    
    if rocket.drogue_chute.kill_rotation
        rocket.angular_momentum = [0;0;0];
        rocket.rotation_rate = [0;0;0];
        rocket.rotation_rate_absolute = [0;0;0];
    end
    
    if ~main_chute_ejected && rocket.velocity(3) < 0 && rocket.position(3) < rocket.main_chute.deployment_altitude; main_chute_ejected = true; disp("main chute");end
    
    
else
    
    
    rocket.forces.drogue_chute_drag  = force_vector([0;0;0], [0;0;1]);


end




if main_chute_ejected

drag_magnitude                 = 0.5*rocket.atmosphere.density*rocket.main_chute.area*norm(rocket.velocity - rocket.atmosphere.wind_velocity)^2*rocket.main_chute.coefficient; %calulate drag using Cd and reference area assigned in my_rocket
drag_direction                 = -normalize(rocket.velocity - rocket.atmosphere.wind_velocity); %direction of the force is assumed to be equal to that of the rocket's velocity
drag                           = drag_magnitude*drag_direction;
rocket.forces.main_chute_drag  = force_vector((rocket.attitude')*drag, rocket.main_chute.position);


if rocket.main_chute.kill_rotation
    rocket.angular_momentum = [0;0;0];
    rocket.rotation_rate = [0;0;0];
    rocket.rotation_rate_absolute = [0;0;0];
end

else


rocket.forces.main_chute_drag  = force_vector([0;0;0], [0;0;1]);

end




end