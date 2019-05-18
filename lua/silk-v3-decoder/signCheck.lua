local _M = {}
--- config.salt
local config = require('silk-v3-decoder/config')

-- 请求路径，不包括参数
local uri = ngx.var.uri;
-- 请求参数
local query = ngx.req.get_uri_args()
-- 时间戳(毫秒)
local ts = query.timestamp
local token = query.token


function _M.say403 ()
  ngx.status = 403
  ngx.exit(ngx.HTTP_FORBIDDEN)
end

function _M.checkToken ()
  if (nil == ts) then
    _M.say403()
    return
  end
  if (nil == token) then
    _M.say403()
    return
  end
  -- 更新系统缓存时间戳
  ngx.update_time();
  local getTime = ngx.time() * 1000;
  local diffTime = math.abs(tonumber(ts) - getTime);
  local token2 = ngx.md5(tostring(uri) .. config.secret .. tostring(ts));
  if (tonumber(diffTime) > 1000000) then
    _M.say403()
  elseif (token2 ~= token) then
    _M.say403()
  end
end

if (ngx.var.request_method ~= "POST") then
  return
else
  _M.checkToken()
end

