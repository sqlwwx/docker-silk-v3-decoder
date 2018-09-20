# docker-silk-v3-decoder - Docker tooling for silk-v3-decoder
## apis
```
curl -d "@test.silk" -X POST /silk/:silkId
GET /silk/:silkId  defualt return mp3
curl --request GET \
  --url /silk/:silkId \
  --header 'voice-type: wav'
curl --request GET \
  --url /silk/:silkId \
  --header 'voice-type: mp3'
GET /silkFiles/test.silk
GET /silkFiles/test.mp3
```
