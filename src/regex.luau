local regex = {}
local utilfunc = require("../utils/func")

local proto_Regex = {}
proto_Regex.__index = proto_Regex
proto_Regex.__metatable = "This metatable is locked"

proto_Regex.isMatch = utilfunc.THROW_NOT_SUPPORTED
proto_Regex.find = utilfunc.THROW_NOT_SUPPORTED
proto_Regex.captures = utilfunc.THROW_NOT_SUPPORTED
proto_Regex.split = utilfunc.THROW_NOT_SUPPORTED
proto_Regex.replace = utilfunc.THROW_NOT_SUPPORTED
proto_Regex.replaceAll = utilfunc.THROW_NOT_SUPPORTED

table.freeze(proto_Regex)

--[[
lune-zune does not support this function.
]]
regex.new = utilfunc.THROW_NOT_SUPPORTED

return table.freeze(regex)