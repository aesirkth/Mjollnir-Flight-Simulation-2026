function rocket = base_manual_atmosphere_model(rocket, declare_dependencies)
% This model queries a csv for pressure, wind and temperature data, from
% which drift, mach-number, etc can be derived.

    persistent init
    persistent pressure
    persistent temperature
    persistent density
    persistent speed_of_sound
    persistent wind_velocity
    
    % On startup
    if declare_dependencies
        
        rocket.position = [0;0;0];
        if ~isfield(rocket, "atmosphere"); rocket.atmosphere = struct(); end
        rocket.atmosphere.dataset_path = replace(mfilename("fullpath"), 'Models\base_manual_atmosphere_model', "Assets\2025111700-02185.csv");
        rocket.atmosphere.wind_velocity_layers = jsondecode('[{"x":0,"y":0,"h":0},{"x":1,"y":5,"h":100},{"x":10,"y":5,"h":200},{"x":3,"y":7,"h":600}]');

    else
        
        if isempty(init)
            try
                rawdata = readtable(rocket.atmosphere.dataset_path);
            catch ME
                disp(ME.message)
                f = uifigure();
                l=uigridlayout(f, [1,1]);
                uibutton(l, "Text","Trouble finding atmosphere data?", "ButtonPushedFcn",@(~,~)web("https://weather.uwyo.edu/upperair/sounding.shtml"));
            end
            
            
            raw_pressure            = rawdata.pressure_hPa         (1:end);
            raw_altitude            = rawdata.geopotentialHeight_m (1:end);
            raw_temperature         = rawdata.temperature_C        (1:end);
            
            nan_elements            = isnan(raw_pressure) | isnan(raw_altitude) | isnan(raw_temperature);
            
            raw_pressure            = raw_pressure      (~nan_elements);
            raw_altitude            = raw_altitude      (~nan_elements);
            raw_temperature         = raw_temperature   (~nan_elements);
            
            
            raw_pressure            = [raw_pressure(1)       ; raw_pressure(:)      ];
            raw_altitude            = [-1                    ; raw_altitude(:)      ];
            raw_temperature         = [raw_temperature(1)    ; raw_temperature(:)   ];
            
            air_molar_mass          = 28.97*1e-3;
            R                       = 8.31446261815324;
            celsius2kelvin          = 273.15;
            air_specific_heat_ratio = 1.4;
            
            wind                    = num2cell(rocket.atmosphere.wind_velocity_layers);
            wind_vector             = zeros(3,numel(wind));
            wind_heights            = zeros(1,numel(wind));
            
            for index = 1:numel(wind)
                wind_layer = wind{index};
                if isfield(wind_layer, "x"); wind_vector (1, index) = wind_layer.x; else; wind_vector (1, index) = 0; end
                if isfield(wind_layer, "y"); wind_vector (2, index) = wind_layer.y; else; wind_vector (2, index) = 0; end
                if isfield(wind_layer, "z"); wind_vector (3, index) = wind_layer.z; else; wind_vector (3, index) = 0; end
                if isfield(wind_layer, "h"); wind_heights(   index) = wind_layer.h; else; wind_heights(   index) = 0; end
            end
            
            pressure       = @(h) makima(raw_altitude, raw_pressure,    h)*1e2;
            temperature    = @(h) makima(raw_altitude, raw_temperature, h)  + celsius2kelvin;
            density        = @(h) pressure(h) * air_molar_mass/(R * (temperature(h)));
            speed_of_sound = @(h) sqrt(air_specific_heat_ratio *pressure(h) / density(h) );
            wind_velocity  = @(h) makima(wind_heights, wind_vector, h);
            
            init = false;
        end
        
        
        rocket.atmosphere.pressure       = pressure       ( rocket.position(3) );
        rocket.atmosphere.temperature    = temperature    ( rocket.position(3) );
        rocket.atmosphere.density        = density        ( rocket.position(3) );
        rocket.atmosphere.speed_of_sound = speed_of_sound ( rocket.position(3) );
        rocket.atmosphere.wind_velocity  = wind_velocity  ( rocket.position(3) );
    
    
    end
end