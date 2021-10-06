FROM python:3.9-slim
COPY requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt
COPY ./app.py /app.py
COPY ./templates/ /templates/
EXPOSE 5000
ENTRYPOINT ["python", "app.py"]
