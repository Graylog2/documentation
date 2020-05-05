FROM python:3-alpine

MAINTAINER Jan Doberstein <jan@graylog.com>

COPY ./requirements.txt requirements.txt

RUN apk add --no-cache --virtual --update py3-pip make wget ca-certificates ttf-dejavu \
    && pip install --upgrade pip \
    && pip install --no-cache-dir  -r requirements.txt

COPY ./server.py /opt/sphinx-server/
COPY ./.sphinx-server.yml /opt/sphinx-server/

WORKDIR /web

EXPOSE 8000 35729

CMD ["python", "/opt/sphinx-server/server.py"]
