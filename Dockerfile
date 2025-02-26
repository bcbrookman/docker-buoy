FROM python:slim
COPY app.py /
COPY templates/ /templates/
COPY static/ /static/
RUN --mount=type=bind,source=requirements/app.txt,target=/requirements.txt \
 apt update -y \
 && apt install -y gcc python3-dev --no-install-recommends \
 && pip3 install -r /requirements.txt \
 && apt purge -y --auto-remove gcc python3-dev \
 && rm -rf /var/lib/apt/lists/*

EXPOSE 5000
CMD ["python", "app.py"]
