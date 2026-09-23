function log = simulate_rocket(rocket)

path = erase(string(mfilename("fullpath")), "lib\simulate_rocket");
addpath(genpath(path));

if ~isfield (rocket, "t_max");      rocket.t_max        = 100;     end   
if ~isfield (rocket, "ode_solver"); rocket.ode_solver   = @ode45;  end


    %% Simulation:
    
    clear logger
    disp("Simulating...")
    rocket.t = 0;

    tic

    rocket = bake_rocket(rocket, false);

    initial_state_vector = rocket2state_vector(rocket);
    t_range = [0, rocket.t_max];
    rocket.ode_solver( @(t,state_vector) system_equations(t,state_vector,rocket), t_range,  initial_state_vector);
    rocket.simulation_time = toc;
    rocket.simulated = true;
    disp  ("Simulating/Done.")
    log = logger();

end