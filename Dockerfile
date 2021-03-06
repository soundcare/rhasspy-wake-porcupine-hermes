FROM python:3.7-slim-buster

WORKDIR /

COPY rhasspywake_porcupine_hermes/ /rhasspywake_porcupine_hermes
COPY . /
RUN apt-get update && apt-get install -y build-essential zlib1g-dev \
    python3-dev \
    cython3 \
    portaudio19-dev \
    wget \
    gcc \
    make \
    sox
RUN ./configure
RUN make
RUN make install
COPY ./pvporcupine_overrides/util.py /usr/local/lib/python3.7/site-packages/pvporcupine/util.py

ENTRYPOINT ["python3", "-m", "rhasspywake_porcupine_hermes"]
