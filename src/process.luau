--!nolint UnknownGlobal
--!nocheck

local process = {}
local utilfunc = require("../utils/func")

process.os = zune.platform.os
process.arch = zune.platform.cpu.arch
process.endianness = zune.platform.cpu.endian
process.args = zune.process.args
process.cwd = zune.process.cwd()
process.env = zune.process.env

process.exit = zune.process.exit
process.create = utilfunc.THROW_NOT_SUPPORTED
process.exec = utilfunc.THROW_NOT_SUPPORTED

return table.freeze(process)