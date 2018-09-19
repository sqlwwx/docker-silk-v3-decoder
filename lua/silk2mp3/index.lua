local utils = require('silk2mp3/utils')
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
  local mp3FileName = buildFileName("mp3")
  local mp3URI = utils.buildURI("mp3")
  if fileExists(mp3FileName) then
    return ngx.exec(mp3URI)
  end
  local silkFileName = buildFileName("silk")
  if not fileExists(silkFileName) then
    return ngx.exit(404);
  end
  utils.converSilk2Mp3(silkFileName)
  if fileExists(mp3FileName) then
    return ngx.exec(mp3URI)
  else
    return ngx.exit(404)
  end
end
