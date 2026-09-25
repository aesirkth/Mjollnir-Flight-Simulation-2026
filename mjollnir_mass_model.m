function rocket = mjollnir_mass_model(rocket, declare_dependencies)

    if declare_dependencies
        rocket.rigid_body.is_rigid_body = true;
        rocket.rigid_body.position = rocket.mjollnir_dry_cg;
        rocket.rigid_body.mass = rocket.mjollnir_dry_mass;
        rocket.rigid_body.moment_of_inertia = [ ...
             6.148e10, -2.485e5, -1.571e6; ...
            -2.485e5,   6.148e10, -3.588e6; ...
            -1.571e6,  -3.588e6,  2.047e8]*1e-9;

        rocket = rmfield(rocket, {'mjollnir_dry_mass', 'mjollnir_dry_cg'});
        rocket = base_update_center_of_mass(rocket, true);
        rocket = base_update_center_of_mass(rocket, false);
    end
end
