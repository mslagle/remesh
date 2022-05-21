FROM python:3.8.13-alpine3.15

EXPOSE 5000
WORKDIR /app
COPY app.py app.py

RUN pip3 install nltk pillow flask

ENTRYPOINT [ "python", "app.py" ] 