"""This module contains all of the functions and Flask routes
which renders all the content.
"""

import hashlib
import platform
from flask import Flask, jsonify, render_template, send_from_directory
import psutil
from waitress import serve


app = Flask(__name__, static_folder=None)

def hash_color(input_string):
    """
    Derives a hex color code from the MD5 hash of an input string.
    Returns the resulting hex color code as a string.
    """
    digest_chars = list(hashlib.md5(input_string).hexdigest())
    color = ""
    while len(color) < 6:
        color += digest_chars.pop(0)
        color += digest_chars.pop(-1)
    return color

@app.route("/")
def root():
    """
    Flask route function for the root ("/") path.
    Returns the index.html template.
    """
    return render_template("index.html")

@app.route("/static/<path:name>")
def static(name):
    """
    Flask route function to serve static files under "/static/".
    Less performant, but avoids the need for a seperate webserver.
    """
    return send_from_directory("static/", name)

@app.route("/sysinfo")
def sysinfo():
    """
    Flask route function for the "/sysinfo" path.
    Returns system information in JSON.
    """
    info={
        'hostname': platform.node(),
        'kernel_system': platform.system(),
        'kernel_release': platform.release(),
        'kernel_version': platform.version(),
        'kernel_architecture': platform.machine(),
        'cpu_count_physical': psutil.cpu_count(logical=False),
        'cpu_count_logical': psutil.cpu_count(logical=True),
        'mem_total_bytes': psutil.virtual_memory().total,
    }

    # Derive a unique color for the container/host from the sysinfo
    info['color']=hash_color(str(info).encode())

    return jsonify(info)

if __name__ == "__main__":
    serve(app, listen='*:5000')
