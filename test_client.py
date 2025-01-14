import os
import requests
import subprocess

# Start the server using subprocess
server_process = subprocess.Popen(["python", "server.py", "--port=44441"])


# Create the output folder if it doesn't exist
if not os.path.exists("output"):
    os.makedirs("output")

# Get a list of files with 'req' in their filename
files = [file for file in os.listdir("examples/trias") if "req" in file]

# Send each file to the server and store the result
for file in files:
    with open("examples/trias/"+file, "r", encoding="utf-8") as f:
        data = f.read()

    # Send the request to the server
    response = requests.post("http://localhost:44441", data=data)

    # Create the output filename with 'req' replaced by 'res'
    output_filename = file.replace("req", "res")
    output_filepath = os.path.join("output", output_filename)

    # Store the result in the output file
    with open(output_filepath, "w", encoding="utf-8") as f:
        f.write(response.text)