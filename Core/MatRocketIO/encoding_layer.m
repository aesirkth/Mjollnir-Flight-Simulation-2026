classdef encoding_layer < handle
properties

    transmit_layer
    input_buffer
    input_queue
    input_queue_is_empty
    parse_method

    

end



methods

    function self = encoding_layer(args)
        arguments
            args.transmit_layer = tcpserver('127.0.0.1', 50007)
        end
        self.transmit_layer        = args.transmit_layer;
        self.input_buffer          = uint8([]);
        self.parse_method          = @(message) [];
        self.input_queue           = {};
        self.input_queue_is_empty  = true;

    end


    function read(self)
        self.read_bytes();
        self.parse_buffer();
        self.parse_input_queue();

    end


    function read_bytes(self)
        if self.transmit_layer.NumBytesAvailable ~= 0
        new_bytes  = self.transmit_layer.read(self.transmit_layer.NumBytesAvailable);
        self.input_buffer(end+1:end+numel(new_bytes)) = new_bytes;
        end
    end


    function parse_buffer(self)
        intact_header  = (numel(self.input_buffer) > 4);
        intact_payload = true;

        while intact_header && intact_payload
            header_raw = swapbytes(self.input_buffer(1:4));
            numbytes   = typecast(header_raw, 'uint32');
            
            intact_payload = (numel(self.input_buffer) >= numbytes+4);
            if intact_payload
                % Decode message and add it to the input queue
                message           = decode_matrocket_protocol(self.input_buffer(5:4+numbytes));
                self.input_queue_is_empty = false;
                self.input_queue{end+1} = message;
                
                % Clear decoded message from input buffer
                self.input_buffer = self.input_buffer(5+numbytes:end);
                intact_header     =  (numel(self.input_buffer) > 4);
    
            end
        end

    end


    function parse_input_queue(self)

   
        input_index               = 1;
        while input_index        <= numel(self.input_queue)
            
            message               = self.input_queue{input_index};
            self.parse_method(message);
            input_index           = input_index+1;
        end
        self.input_queue          = {};
        self.input_queue_is_empty = true;


    end



    
    function write(self, message)

        encoded_message = encode_matrocket_protocol(message);
        self.transmit_layer.write(encoded_message, "uint8");
        
    end




    function delete(self)
        delete(self.transmit_layer);
    end
    

end


end


function message = decode_matrocket_protocol(message_raw)
    message = jsondecode(char(message_raw));
end


function encoded_message = encode_matrocket_protocol(message)


        payload     = uint8(jsonencode(message));
        header      = typecast(uint32(numel(payload)), "uint8");
        encoded_message = [header payload];
        
end