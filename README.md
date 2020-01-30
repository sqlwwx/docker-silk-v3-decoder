# docker-silk-v3-decoder - Docker tooling for silk-v3-decoder
![Docker](https://github.com/sqlwwx/docker-silk-v3-decoder/workflows/Docker/badge.svg)

## images
```
sqlwwx/silk-v3-decoder
sqlwwx/silk-v3-decoder-openresty
sqlwwx/silk-v3-decoder-alinode
```

## start server

```
docker run -p 8080:80 -t sqlwwx/silk-v3-decoder-openresty
```

## apis

1. upload silk

```
POST /silk/:silkId
curl --data-binary @test.silk http://127.0.0.1:8080/silk/test
```

2. converter to mp3

```
GET /silk/:silkId  # defualt return mp3

curl http://127.0.0.1:8080/silk/test --header 'voice-type: wav'
curl http://127.0.0.1:8080/silk/test

ffplay http://127.0.0.1:8080/silk/test
```
