local datetime = {}
local utilfunc = require("../utils/func")

datetime.unixTimestamp = "NONE"
datetime.unixTimestampMillis = "NONE"

datetime.now = utilfunc.THROW_NOT_SUPPORTED
datetime.fromUnixTimestamp = utilfunc.THROW_NOT_SUPPORTED
datetime.fromUniversalTime = utilfunc.THROW_NOT_SUPPORTED
datetime.fromLocalTime = utilfunc.THROW_NOT_SUPPORTED
datetime.fromIsoDate = utilfunc.THROW_NOT_SUPPORTED
datetime.fromRfc3339 = utilfunc.THROW_NOT_SUPPORTED
datetime.fromRfc2822 = utilfunc.THROW_NOT_SUPPORTED

return table.freeze(datetime)