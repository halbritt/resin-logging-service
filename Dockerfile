FROM python:3.6-alpine as python-base
COPY requirements.txt .
RUN apk --update upgrade &&\
    apk add \
    git \
    gcc \
    libffi-dev \
    musl-dev \
    openssl-dev && \
    python3 -m ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    pip install -r requirements.txt && \
    pip install git+https://github.com/resin-io/resin-sdk-python.git

FROM python:3.6-alpine
COPY --from=python-base /root/.cache /root/.cache
COPY requirements2.txt .
RUN python3 -m ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    pip install -r requirements2.txt && \
    rm -rf /root/.cache
