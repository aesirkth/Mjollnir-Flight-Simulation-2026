import bpy
import threading
import time
import socket
import queue
import atexit
import mathutils

global RUNNING, s

RUNNING = True
HOST = '127.0.0.1'
PORT = 50007
print("Starting socket listener thread...")

#def cleanup():
#    global RUNNING
#    RUNNING = False
#    s.close()

#atexit.register(cleanup)

command_queue = queue.Queue()


def execute_commands():
    if not command_queue.empty():
        cmd = command_queue.get()
        try:
            exec(cmd)
        except Exception as e:
            print("Error running command:", e)
        
        time.sleep(0.1)

def socket_listener():
    global RUNNING, s

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((HOST, PORT)) 
    print("waiting for MATLAB...")



    while RUNNING:
        data = s.recv(4096)
        if not data:
            RUNNING = False
            break
        command_queue.put(data.decode("utf8"))

    s.close()

# ---- COMMAND EXECUTION TIMER ----
def blender_command_pump():
    global s, RUNNING
    """This function returns how long until it should be run again."""
    if not RUNNING:
        return None   # unregister the timer

    if not command_queue.empty():
        cmd = command_queue.get()
        print(cmd)
        try:
            exec(cmd)
        except Exception as e:
            print("Command error:", e)

    # return a delay so Blender stays responsive
    return 0.01


# ---- START THREAD + TIMER ----
threading.Thread(target=socket_listener, daemon=True).start()
bpy.app.timers.register(blender_command_pump)