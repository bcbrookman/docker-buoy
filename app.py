from flask import Flask, jsonify, render_template
import hashlib
import os
import platform
import psutil


app = Flask(__name__)

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
	app.run(host="0.0.0.0")
