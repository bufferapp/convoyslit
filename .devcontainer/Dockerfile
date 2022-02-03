FROM mcr.microsoft.com/vscode/devcontainers/python:3.10

COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt
RUN pip install black

COPY app.py /app/

WORKDIR /app