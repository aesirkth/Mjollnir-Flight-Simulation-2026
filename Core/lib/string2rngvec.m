        function v = string2rngvec(str)
            % Convert string to a deterministic numeric seed
            bytes = uint8(char(str));
            seed = sum(uint32(bytes) .* uint32(1:numel(bytes)));
        
            % Seed RNG
            rng(seed, 'twister');
        
            % Generate deterministic random vector
            v = rand(1,3);
        end