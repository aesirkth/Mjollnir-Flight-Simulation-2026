function rocket = base_equations_of_motion_model(rocket, declare_dependencies)


if declare_dependencies

    %% Rigid-body model 6DoF

    rocket.attitude               = eye(3);
    rocket.rotation_rate          = [0;0;0];
    rocket.position               = [0;0;0];
    rocket.velocity               = [0;0;0];
    rocket.center_of_mass_summed  = [0;0;0];
    rocket.forces_summed          = struct();
    rocket.forces_summed.vector   = [0;0;0];
    rocket.forces_summed.position = [0;0;0];
    rocket.center_of_mass_summed  = [0;0;0];
    rocket.mass_summed            = 1;
    rocket                        = base_update_center_of_mass (rocket, true);
    rocket                        = base_update_forces         (rocket, true);
    rocket                        = base_update_velocity       (rocket, true);

      
else



    rocket = base_update_center_of_mass(rocket, false);
    rocket = base_update_forces(rocket, false);
    

    rotation_rate_tensor = [  0                       -rocket.rotation_rate(3)        rocket.rotation_rate(2);
                              rocket.rotation_rate(3)  0                             -rocket.rotation_rate(1);
                             -rocket.rotation_rate(2)  rocket.rotation_rate(1)        0                      ];
    
    
    
    force_sum                               = rocket.attitude* rocket.force_summed .vector;
    moment_sum                              = rocket.attitude*(rocket.moment_summed.vector) + cross(rocket.attitude*rocket.force_summed.position - rocket.center_of_mass_summed, rocket.attitude*rocket.force_summed.vector);
   
    rocket.acceleration                     = force_sum/rocket.mass_summed;
    attitude_derivative                     = rotation_rate_tensor*rocket.attitude;

    attitude_lead                           = rocket.attitude + attitude_derivative*0.0004;
    normalized_attitude_lead                = orthonormalize(rocket.attitude + attitude_derivative*0.0004);

    rocket.lead_normalization_correction    = normalized_attitude_lead - attitude_lead;
    %rocket.normalization_correction         = (normalize(rocket.attitude) - rocket.attitude)*0.0004;

    rocket.derivative("position")           = rocket.velocity ;
    rocket.derivative("velocity")           = rocket.acceleration; 
    rocket.derivative("angular_momentum")   = moment_sum;
    rocket.derivative("attitude")           = attitude_derivative + rocket.lead_normalization_correction;


end
end