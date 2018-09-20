local _M = {}
-- nginx.var silkId
-- config.silkDir
-- config.silkDecoderPath
local config = require('silk-v3-decoder/config')

function _M.getFile(fileName)
  local f = assert(io.open(fileName, 'r'))
  local string = f:read("*all")
  f:close()
  return string
end

function _M.fileExists(fileName)
  local f=io.open(fileName,"r")
  if f~=nil then io.close(f) return true else return false end
end

function _M.buildURI (ext)
  return string.format(
    "/%s/%s.%s",
    config.silkDir,
    ngx.var.silkId,
    ext
  )
end

function _M.buildFileName(ext)
  return string.format(
    "%s/%s/%s.%s",
    ngx.var.realpath_root,
    config.silkDir,
    ngx.var.silkId,
    ext
  )
end

function _M.writeFile(fileName, data)
  local file, err =io.open(fileName, "w+")
  if not file then
    ngx.log(ngx.ERR, err)
    return err
  else
    file:write(data)
    file:close()
  end
end

function _M.ngxRequestBody()
  ngx.req.read_body()
  local data = ngx.req.get_body_data()
  if nil == data then
    local file_name = ngx.req.get_body_file()
    ngx.say(">> temp file: ", file_name)
    if file_name then
      data = _M.getFile(file_name)
    end
  end
  return data
end

function _M.converSilk(silkFileName, voiceType)
  os.execute(config.silkDecoderPath.." \""..silkFileName.."\" "..voiceType.." > /dev/null 2>&1");
end

return _M
