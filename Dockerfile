FROM alpine:latest as builder

RUN apk add --no-cache git make gcc g++

RUN git clone https://github.com/kn007/silk-v3-decoder.git \
    && chmod +x silk-v3-decoder/converter.sh \
    && cd silk-v3-decoder/silk \
    && make

FROM openresty/openresty:alpine

RUN apk add --no-cache ffmpeg bash

RUN mkdir -p /silk-v3-decoder/silk
RUN mkdir -p /silk-v3-decoder/www
RUN mkdir -p /silk-v3-decoder/www/voice

# copy silk-v3-decoder
COPY --from=builder /silk-v3-decoder/converter.sh /silk-v3-decoder/
COPY --from=builder /silk-v3-decoder/silk/decoder /silk-v3-decoder/silk/

# add crontab file
ADD ./scripts/clean.sh /etc/periodic/daily/clean

# nginx config
ADD ./nginx.conf /usr/local/openresty/nginx/conf/
ADD ./lua/silk-v3-decoder /usr/local/openresty/site/lualib/silk-v3-decoder

ADD ./scripts/run.sh /
CMD ["/run.sh"]
