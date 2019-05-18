local _M = {}

_M.silkDecoderPath = "/silk-v3-decoder/converter.sh"
_M.silkDir = "voice"
_M.secret = os.getenv("SECRET") or "SECRET"

return _M
