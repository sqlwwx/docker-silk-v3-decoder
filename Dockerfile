FROM alpine:latest as builder

RUN apk add --no-cache git make gcc g++

RUN git clone https://github.com/kn007/silk-v3-decoder.git \
    && chmod +x silk-v3-decoder/converter.sh \
    && cd silk-v3-decoder/silk \
    && make

FROM openresty/openresty:alpine

RUN apk add --no-cache ffmpeg bash

RUN mkdir -p /silk2mp3/silk
RUN mkdir -p /silk2mp3/files
RUN mkdir -p /silk2mp3/files/silkFiles

COPY --from=builder /silk-v3-decoder/converter.sh /silk2mp3/
COPY --from=builder /silk-v3-decoder/silk/decoder /silk2mp3/silk/

ADD ./nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD ./lua/silk2mp3 /usr/local/openresty/site/lualib/silk2mp3
