classdef remote_state < handle
    properties(Hidden)
    
    
        state_remote
        state_local
    
    end
    properties
        
        encoding_layer
    
    end
    methods(Hidden)
    
        function state_update(self,message)
            state = message;
            self.state_remote = struct_append(self.state_remote, state);
        end
    
    
    end
    methods

    
        function self = remote_state(args)
            arguments
                args.encoding_layer = encoding_layer();
    
            end
            
            self.encoding_layer = args.encoding_layer;
            self.state_local  = struct();
            self.state_remote = struct();
            self.encoding_layer.parse_method = @self.state_update;
    
    
        end
    
        function state = sync_local(self, state)
            arguments
                self
                state = struct();
            end
            self.encoding_layer.read()
            state = struct_append(state, self.state_remote);
        end
    
        function sync_remote(self, state)
            state            = rm_nonjsonfields(state);
            delta            = struct_difference(self.state_local, state);
            self.state_local = state;
            message          = delta;
            self.encoding_layer.write(message)
        
        end

        function delete(self)
        delete(self.encoding_layer)

        end
    
    
    end
end
    
   