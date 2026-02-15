--!nolint UnknownGlobal
--!nocheck

local process = {}
local utilfunc = require("../utils/func")

local proto_ChildProcessReader = {}
proto_ChildProcessReader.__index = proto_ChildProcessReader
proto_ChildProcessReader.__metatable = "This metatable is locked"

proto_ChildProcessReader.read = utilfunc.THROW_NOT_SUPPORTED
proto_ChildProcessReader.readToEnd = utilfunc.THROW_NOT_SUPPORTED

table.freeze(proto_ChildProcessReader)

local proto_ChildProcessWriter = {}
proto_ChildProcessWriter.__index = proto_ChildProcessWriter
proto_ChildProcessWriter.__metatable = "This metatable is locked"

proto_ChildProcessWriter.write = utilfunc.THROW_NOT_SUPPORTED
proto_ChildProcessWriter.close = utilfunc.THROW_NOT_SUPPORTED

table.freeze(proto_ChildProcessWriter)

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