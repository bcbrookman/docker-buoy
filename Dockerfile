# Set base image
FROM python:3.14-slim@sha256:cea0e6040540fb2b965b6e7fb5ffa00871e632eef63719f0ea54bca189ce14a6

# Set static instructions
WORKDIR /buoy/
EXPOSE 5000/tcp
CMD ["python", "app.py"]

# Install dependencies
RUN --mount=type=bind,source=requirements/app.txt,target=/requirements.txt \
 set PIP_OPTS="--no-input --no-cache-dir --root-user-action=ignore --prefer-binary --upgrade" \
 && pip install ${PIP_OPTS} pip \
 && pip install ${PIP_OPTS} -r /requirements.txt

# Setup non-root user
RUN useradd -u 1001 -M buoy
USER buoy:buoy

# Copy project files
COPY templates/ templates/
COPY static/ static/
COPY app.py app.py
