local datetime = {}
local utilfunc = require("../utils/func")

local proto_DateTime = {}
proto_DateTime.__index = proto_DateTime
proto_DateTime.__metatable = "This metatable is locked"

proto_DateTime.formatLocalTime = utilfunc.THROW_NOT_SUPPORTED
proto_DateTime.formatUniversalTime = utilfunc.THROW_NOT_SUPPORTED
proto_DateTime.toIsoDate = utilfunc.THROW_NOT_SUPPORTED
proto_DateTime.toRfc2822 = utilfunc.THROW_NOT_SUPPORTED
proto_DateTime.toRfc3339 = utilfunc.THROW_NOT_SUPPORTED
proto_DateTime.toLocalTime = utilfunc.THROW_NOT_SUPPORTED
proto_DateTime.toUniversalTime = utilfunc.THROW_NOT_SUPPORTED

table.freeze(proto_DateTime)

datetime.now = utilfunc.THROW_NOT_SUPPORTED
datetime.fromUnixTimestamp = utilfunc.THROW_NOT_SUPPORTED
datetime.fromUniversalTime = utilfunc.THROW_NOT_SUPPORTED
datetime.fromLocalTime = utilfunc.THROW_NOT_SUPPORTED
datetime.fromIsoDate = utilfunc.THROW_NOT_SUPPORTED
datetime.fromRfc3339 = utilfunc.THROW_NOT_SUPPORTED
datetime.fromRfc2822 = utilfunc.THROW_NOT_SUPPORTED

return table.freeze(datetime)