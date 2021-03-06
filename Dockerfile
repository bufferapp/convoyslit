FROM python:3.8

RUN pip install --no-cache-dir streamlit convoys numpy pandas altair pandas-gbq google-cloud-bigquery-storage

COPY app.py /app/

WORKDIR /app

CMD ["streamlit",  "run", "app.py"]