local utils = require('silk-v3-decoder/utils')
local buildFileName = utils.buildFileName
local fileExists = utils.fileExists

if ngx.var.request_method == "POST" then
  local data = utils.ngxRequestBody()
  local silkFileName = buildFileName("silk")
  local err = utils.writeFile(silkFileName, data)
  if err then
    ngx.log(ngx.ERR, err)
    ngx.exit(500)
  else
    ngx.say("success")
  end
else
  local voiceType = ngx.req.get_headers()["voice-type"] or "mp3"
  local voiceFileName = buildFileName(voiceType)
  local voiceURI = utils.buildURI(voiceType)
  if fileExists(voiceFileName) then
    return ngx.exec(voiceURI)
  end
  local silkFileName = buildFileName("silk")
  if not fileExists(silkFileName) then
    return ngx.exit(404);
  end
  utils.converSilk(silkFileName, voiceType)
  if fileExists(voiceFileName) then
    return ngx.exec(voiceURI)
  else
    return ngx.exit(404)
  end
end
