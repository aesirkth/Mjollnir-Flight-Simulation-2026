function rocket = base_ground_interaction_model(rocket, declare_dependencies)

if declare_dependencies
    
    rocket.position     = [0;0;0];
    rocket.velocity     = [0;0;0];
    rocket.acceleration = [0;0;0];
    
else
    
    if rocket.position(3) <= 0 && rocket.velocity(3) < 0
    
    
        rocket.derivative("position")         = zeros(3,1); rocket.velocity = [0;0;0];
        rocket.derivative("attitude")         = zeros(3);   rocket.angular_momentum = [0;0;0];
        rocket.derivative("angular_momentum") = zeros(3,1); rocket.acceleration = [0;0;0];
    end
    

end