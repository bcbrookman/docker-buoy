# Set base image
FROM python:3.13-slim@sha256:58c30f5bfaa718b5803a53393190b9c68bd517c44c6c94c1b6c8c172bcfad040

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
