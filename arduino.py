from flask import Flask, jsonify
import serial
import sys
from threading import Thread

app = Flask(__name__)

latest_data = ""  # Variable to store the latest serial data

# Endpoint to get the latest serial data
@app.route('/api/serial_data', methods=['GET'])
def get_serial_data():
    global latest_data
    return jsonify({"data": latest_data})

def read_serial(comport, baudrate):
    global latest_data
    try:
        ser = serial.Serial(comport, baudrate, timeout=0.1)
        print(f"Connected to {comport} at {baudrate} baud")

        while True:
            data = ser.readline().decode('utf-8').strip()  # Decode bytes to string and strip newline characters
            if data:
                print(data)
                latest_data = data  # Update latest_data with the received serial data

    except serial.SerialException as e:
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == '__main__':
    # Start a separate thread to continuously read serial data
    serial_thread = Thread(target=read_serial, args=('COM3', 9600))
    serial_thread.daemon = True  # Daemonize the thread so it exits when the main program exits
    serial_thread.start()

    # Start the Flask app
    app.run(host='0.0.0.0', port=5000)  # Run the app on all available interfaces on port 5000










# import serial
# import sys

# def read_serial(comport, baudrate):
#     try:
#         ser = serial.Serial(comport, baudrate, timeout=0.1)
#         print(f"Connected to {comport} at {baudrate} baud")

#         while True:
#             data = ser.readline().decode('utf-8').strip()  # Decode bytes to string and strip newline characters
#             # print("hi")
#             if data:
#                 print(data)

#     except serial.SerialException as e:
#         print(f"Error: {e}")
#         sys.exit(1)

# if __name__ == '__main__':
#     read_serial('COM3', 9600)