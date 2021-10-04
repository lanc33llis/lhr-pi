ARG reload

FROM python:3.9-slim-buster AS base
RUN mkdir /lhr-pi
COPY requirements.txt /lhr-pi
RUN pip3 install --no-cache-dir --upgrade -r /lhr-pi/requirements.txt
COPY app /lhr-pi/app
WORKDIR /lhr-pi

FROM base AS branch-version-true
ENV RELOAD="--reload"

FROM base AS branch-version-false
ENV RELOAD=""

FROM base AS branch-version-
ENV RELOAD=""

FROM branch-version-${reload} AS final
CMD uvicorn app.main:app --host 0.0.0.0 --port 5000 $RELOAD