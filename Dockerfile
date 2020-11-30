FROM python:3.7-slim-buster
ARG PORCUPINE_LIB=linux/x86_64
ARG PORCUPINE_KW=linux/snowboy.ppn

COPY rhasspywake_porcupine_hermes/porcupine/lib/common/porcupine_params.pv /porcupine/
COPY rhasspywake_porcupine_hermes/porcupine/lib/${PORCUPINE_LIB}/libpv_porcupine.so /porcupine/
COPY rhasspywake_porcupine_hermes/porcupine/resources/keyword_files/${PORCUPINE_KW}/ /porcupine/keywords/

WORKDIR /

COPY rhasspywake_porcupine_hermes/ /rhasspywake_porcupine_hermes
COPY . /
RUN apt-get update && apt-get install -y build-essential \
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


ENTRYPOINT ["python3", "-m", "rhasspywake_porcupine_hermes", "--library", "/porcupine/libpv_porcupine.so", "--model", "/porcupine/porcupine_params.pv"]
