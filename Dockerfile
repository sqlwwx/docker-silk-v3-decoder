FROM alpine:latest

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk upgrade --no-cache \
    && apk add --no-cache git make gcc g++

RUN git clone --depth=1 https://github.com/kn007/silk-v3-decoder.git \
    && chmod +x silk-v3-decoder/converter.sh \
    && cd silk-v3-decoder/silk \
    && make
