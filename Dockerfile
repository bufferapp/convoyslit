FROM python:3.8

RUN pip install --no-cache-dir streamlit convoys numpy pandas matplotlib pandas-gbq google-cloud-bigquery-storage

COPY app.py /app/

WORKDIR /app

CMD ["streamlit",  "hello"]