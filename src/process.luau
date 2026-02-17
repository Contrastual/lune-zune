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

--[[
lune-zune does not support this function.
]]
proto_ChildProcessWriter.write = utilfunc.THROW_NOT_SUPPORTED

--[[
lune-zune does not support this function.
]]
proto_ChildProcessWriter.close = utilfunc.THROW_NOT_SUPPORTED

table.freeze(proto_ChildProcessWriter)

--[[
The current operating system being used.

Possible values:
- `"linux"`
- `"macos"`
- `"windows"`

Additional values exclusive to ZUNE:
- `"freebsd"`
]]
process.os = zune.platform.os

--[[
The architecture of the processor currently being used.

Possible values:
- `"x86_64"`
- `"aarch64"`

Additional values exclusive to ZUNE:
- `"powerpc64le"`
- `"riscv64"`
]]
process.arch = zune.platform.cpu.arch

--[[
The endianness of the processor currently being used.

Possible values:
- `"big"`
- `"little"`
]]
process.endianness = zune.platform.cpu.endian

--[[
The arguments given when running the Lune script.
]]
process.args = zune.process.args

--[[
The current working directory in which the Lune script is running.
]]
process.cwd = zune.process.cwd()

--[[
Current environment variables for this process.

Setting a value on this table will set the corresponding environment variable.
]]
process.env = zune.process.env

--[[
Exits the currently running script as soon as possible with the given exit code.

Exit code 0 is treated as a successful exit, any other value is treated as an error.

Setting the exit code using this function will override any otherwise automatic exit code.
]]
process.exit = zune.process.exit

--[[
lune-zune does not support this function.
]]
process.create = utilfunc.THROW_NOT_SUPPORTED

--[[
lune-zune does not support this function.
]]
process.exec = utilfunc.THROW_NOT_SUPPORTED

return table.freeze(process)