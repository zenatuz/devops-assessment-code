FROM python:3.11-alpine 
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt
COPY . /app
CMD flask --app main run --host=0.0.0.0 --port=8080