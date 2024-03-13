FROM python:3.11.5

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . .

RUN apt-get update && apt-get install -y libpq-dev build-essential
RUN pip install --upgrade pip
RUN pip install --no-cache-dir --upgrade -r requirements.txt
RUN apt update
RUN apt install -y libgl1-mesa-dev
RUN pip install opencv-python==4.6.0.66
RUN pip install --upgrade ultralytics

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]
