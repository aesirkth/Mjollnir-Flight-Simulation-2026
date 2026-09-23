function rocket = base_HRAP_propulsion_model(rocket, declare_dependencies)
% Thrust curve and masses from HRAP

persistent init
persistent thrust_force
persistent oxidizer_mass
persistent fuel_mass



if declare_dependencies

    if ~isfield(rocket, "engine"); rocket.engine = struct(); end
    rocket.engine.is_rigid_body = true;
    rocket.engine.forces = struct();

    rocket.engine                            = struct();
    rocket.engine.HRAP_file_path             = replace(mfilename("fullpath"), 'Models\base_HRAP_propulsion_model', 'Assets\HRAP_output.csv');
    rocket.engine.is_rigid_body              = true;
    rocket.engine.forces                     = struct();
    rocket.engine.fuel_grain                 = struct();
    rocket.engine.fuel_grain.is_rigid_body   = true;
    rocket.engine.fuel_grain.mass            = 1;
    rocket.engine.oxidizer                   = struct();
    rocket.engine.oxidizer.is_rigid_body     = true;
    rocket.engine.oxidizer.mass              = 1;
    

else

    if isempty(init)

        tab = readtable(rocket.engine.HRAP_file_path);
        
        thrust_force   = @(t)interp1(tab.Time_s_, tab.Thrust_N_, t,        "spline", "extrap")*(0 < t && t < 20);
        oxidizer_mass  = @(t)interp1(tab.Time_s_, tab.OxidizerMass_kg_, t, "spline", "extrap")*(0 < t && t < 20);
        fuel_mass      = @(t)interp1(tab.Time_s_, tab.FuelMass_kg_, t,     "spline", "extrap")*(0 < t && t < 20);
        init = false;
    end

    
    rocket.engine.forces.thrust    = force_vector([0;0;1]*thrust_force(rocket.t), [0;0;0]);
    rocket.engine.fuel_grain.mass  = fuel_mass(rocket.t);
    rocket.engine.oxidizer.mass    = oxidizer_mass(rocket.t);



end