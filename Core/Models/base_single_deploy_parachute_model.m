function rocket = base_single_deploy_parachute_model(rocket, declare_dependencies)
% Single deploy chute

persistent chute_ejected

if declare_dependencies

rocket.velocity                       = [0;0;0];
rocket.attitude                       = eye(3);
rocket.forces                         = struct();

if ~isfield(rocket, "atmosphere"); rocket.atmosphere = struct(); end
rocket.atmosphere.density             = 1;
rocket.atmosphere.wind_velocity       = [0;0;0];
if ~isfield(rocket, "chute"); rocket.chute = struct(); end
rocket.chute.area                     = 1;
rocket.chute.coefficient              = 1;
rocket.chute.kill_rotation            = false;
rocket.chute.position                 = [0;0;1];
rocket                                = base_update_velocity(rocket, true);

else





if isempty(chute_ejected); chute_ejected = false; end


if ~chute_ejected && rocket.velocity(3) < 0 && rocket.position(3) > 100; chute_ejected = true; disp("chute");end


if chute_ejected
    
    rocket                           = base_update_velocity(rocket, false);
    drag_magnitude                   = 0.5*rocket.atmosphere.density*rocket.chute.area*norm(rocket.velocity - rocket.atmosphere.wind_velocity)^2*rocket.chute.coefficient; %calulate drag using Cd and reference area assigned in my_rocket
    drag_direction                   = -normalize(rocket.velocity - rocket.atmosphere.wind_velocity); %direction of the force is assumed to be equal to that of the rocket's velocity
    drag                             = drag_magnitude*drag_direction;
    rocket.forces.chute_drag  = force_vector((rocket.attitude')*drag, rocket.chute.position);
    
    if rocket.chute.kill_rotation
        rocket.angular_momentum = [0;0;0];
        rocket.rotation_rate = [0;0;0];
        rocket.rotation_rate_absolute = [0;0;0];
    end

    
else
    
    
    rocket.forces.chute_drag  = force_vector([0;0;0], [0;0;1]);


end





end