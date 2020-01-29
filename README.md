# docker-silk-v3-decoder - Docker tooling for silk-v3-decoder
![Docker](https://github.com/sqlwwx/docker-silk-v3-decoder/workflows/Docker/badge.svg)

## images
```
sqlwwx/silk-v3-decoder
sqlwwx/silk-v3-decoder-alinode
```

## apis
```
curl -d "@test.silk" -X POST /silk/:silkId
GET /silk/:silkId  # defualt return mp3
curl --request GET \
  --url /silk/:silkId \
  --header 'voice-type: wav'
curl --request GET \
  --url /silk/:silkId \
  --header 'voice-type: mp3'
GET /voice/test.silk
GET /voice/test.mp3
```
