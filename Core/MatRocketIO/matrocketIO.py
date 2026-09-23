import socket
import struct
import json
import copy




## API-layer
class remote_state:
    def __init__(self, _encoding_layer=None):
        if _encoding_layer is None:
            _encoding_layer               = encoding_layer()
        self._encoding_layer              = _encoding_layer
        self._encoding_layer.parse_method = self._state_update
        
        self._state_remote                = {}
        self._state_local                 = {}
        
        
    def _state_update(self, message):
        delta = message
        self._state_remote = dict_append(self._state_remote,delta)

    def sync_local(self, state=None):
        if state is None:
            state = {}
        self._encoding_layer.read()
        return dict_append(state, self._state_remote)
    
    def sync_remote(self, state):
        delta = dict_difference(self._state_local, state)
        self._state_local = copy.deepcopy(state)
        message = delta
        self._encoding_layer.write(message)





class encoding_layer:
    def __init__(self, _transmit_layer=None):
        if _transmit_layer is None:
            _transmit_layer  = tcpclient()
        self._transmit_layer = _transmit_layer

        self.input_buffer    = bytearray()
        self.parse_method    = None
        self.input_queue     = []



    def read(self):
        self.read_bytes()
        self.parse_buffer()
        self.parse_input_queue()


    def read_bytes(self):
        if self._transmit_layer is None:
            return

        try:
            while True:
                data = self._transmit_layer.recv(65536)
                if not data:
                    # connection closed by peer
                    return
                self.input_buffer.extend(data)

        except BlockingIOError:
            # no more data available right now
            pass

        except ConnectionResetError:
            # connection reset by peer
            pass

    def parse_buffer(self):
        intact_header = len(self.input_buffer) > 4
        intact_payload = True
        while intact_header and intact_payload:
            header_raw = self.input_buffer[0:4]
            numbytes = struct.unpack("<I", header_raw)[0]
            intact_payload = len(self.input_buffer) >= numbytes + 4
            if intact_payload:
                payload = self.input_buffer[4:4 + numbytes]
                message = decode_matrocket_protocol(payload)

                self.input_queue.append(message)

                # clear decoded message from buffer
                del self.input_buffer[0:4 + numbytes]
                intact_header = len(self.input_buffer) > 4


    def parse_input_queue(self):
        for message in self.input_queue:
            self.parse_method(message)

        self.input_queue.clear()


    def write(self, message):
        message_encoded = encode_matrocket_protocol(message)
        self._transmit_layer.sendall(message_encoded)

    def close(self):
        if self._transmit_layer:
            self._transmit_layer.close()
            self._transmit_layer = None

    def __del__(self):
        self.close()




def tcpserver(client="127.0.0.1", port=50007):
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server_socket.bind((client, port))
    server_socket.listen()

    node, addr = server_socket.accept()
    node.setblocking(False)
    return node


def tcpclient(client="127.0.0.1", port=50007):
    node = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    node.connect((client, port))
    print("connected!")
    node.setblocking(False)
    return node





def encode_matrocket_protocol(message: dict) -> bytes:

    # JSON → UTF-8 bytes (equivalent to uint8(jsonencode))
    payload = json.dumps(message).encode("utf-8")
    header  = struct.pack("<I", len(payload))
    message_encoded   = header + payload
    return message_encoded



def decode_matrocket_protocol(message_raw: bytes) -> dict:
    # UTF-8 bytes → JSON → dict
    message = json.loads(message_raw.decode("utf-8"))

    return message




def dict_difference(dict1: dict, dict2: dict) -> dict:
    delta = {}

    # First pass: fields in dict1
    for child_name in dict1.keys():

        # one is missing
        if child_name not in dict2:
            delta[child_name] = dict1[child_name]

        # one is not a dict
        elif not isinstance(dict1[child_name], dict) or not isinstance(dict2[child_name], dict):
            if dict1[child_name] != dict2[child_name]:
                delta[child_name] = dict2[child_name]

        # both are dicts
        else:
            child_delta = dict_difference(dict1[child_name], dict2[child_name])
            if len(child_delta) > 0:
                delta[child_name] = child_delta

    # Second pass: fields in dict2 missing from dict1
    for child_name in dict2.keys():
        if child_name not in dict1:
            delta[child_name] = dict2[child_name]

    return delta



def dict_append(dict1: dict, dict2: dict) -> dict:
    """
    Add dict2 to dict1 recursively.
    Leaves overwrite, nested dicts merge.
    """
    newdict = {}

    for child_name in dict2.keys():

        # struct2 value is not a dict → overwrite
        if not isinstance(dict2[child_name], dict):
            newdict[child_name] = dict2[child_name]

        # both are dicts → recurse
        elif child_name in dict1:
            newdict[child_name] = dict_append(dict1[child_name], dict2[child_name])

        # missing branch → copy whole subtree
        else:
            newdict[child_name] = dict2[child_name]

    return newdict

