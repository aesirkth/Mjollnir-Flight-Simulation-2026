function rocket = base_gravity_model(rocket, declare_dependencies)



if declare_dependencies
    
    rocket.forces                = struct();
    rocket.attitude              = eye(3);
    rocket.enviroment            = struct();
    rocket.enviroment.g          = 9.82;
    rocket.mass_summed           = 0;
    rocket.center_of_mass_summed = [0;0;0];
    rocket.position              = [0;0;0];
    
    rocket = base_update_center_of_mass(rocket, true);


else


    rocket = base_update_center_of_mass(rocket, false);
    
    rocket.forces.Gravity = force_vector((rocket.attitude')*rocket.enviroment.g*rocket.mass_summed*[0;0;-1], ...
                                         (rocket.attitude')*(rocket.center_of_mass_summed));


end
end