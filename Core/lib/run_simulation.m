function log = run_simulation(rocket)

setup; % In case of multithreading

if ~isfield (rocket, "t_max");      rocket.t_max        = 80;                         end   
if ~isfield (rocket, "ode_solver"); rocket.ode_solver   = @ode45;                     end


    

    %% Simulation:
    
    clear logger
    disp("Simulating...")
    rocket.t = 0;

    tic
    % Sometimes this is run on a seperate instance/thread/whatever and 
    % the models haven't been initialized yet, so this is just to get them out of init-state
             bake_rocket(rocket, true);
    rocket = bake_rocket(rocket, false);
    struct_printout(rocket)
    initial_state_vector = rocket2state_vector(rocket);
    t_range = [0, rocket.t_max];
    rocket.ode_solver( @(t,state_vector) system_equations(t,state_vector,rocket), t_range,  initial_state_vector);
    rocket.simulation_time = toc;
    rocket.simulated = true;
    disp  ("Simulating/Done.")
    log = logger();

