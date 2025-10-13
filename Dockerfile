# Set base image
FROM python:3.14-slim@sha256:5cfac249393fa6c7ebacaf0027a1e127026745e603908b226baa784c52b9d99b

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
