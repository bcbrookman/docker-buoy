# Set base image
FROM python:3.13-slim@sha256:4c2cf9917bd1cbacc5e9b07320025bdb7cdf2df7b0ceaccb55e9dd7e30987419

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
