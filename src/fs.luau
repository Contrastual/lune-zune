--!nolint UnknownGlobal
--!nocheck

local fs = {}
local utilfunc = require("../utils/func")

function fs.readFile(path: string)
  return zune.fs.readFile(path, false)
end

function fs.readDir(path: string)
  local ret = {}
  local filenames = zune.fs.entries(path)
  for _, file in filenames do
    table.insert(ret, file)
  end
  table.sort(ret)
  return ret
end

function fs.writeFile(path: string, contents: string)
  zune.fs.writeFile(path, contents)
end

function fs.writeDir(path: string)
  zune.fs.makeDir(path, true)
end

fs.removeFile = utilfunc.THROW_NOT_SUPPORTED
fs.removeDir = utilfunc.THROW_NOT_SUPPORTED
fs.metadata = utilfunc.THROW_NOT_SUPPORTED
fs.isFile = utilfunc.THROW_NOT_SUPPORTED

function fs.isDir(path: string)
  local s, metadata = pcall(zune.fs.metadata, path)
  if not s then
    return false
  end
  local kind = zune.fs.metadata(path).kind
  return kind == "directory" or kind == "sym_link"
end

fs.move = utilfunc.THROW_NOT_SUPPORTED
fs.copy = utilfunc.THROW_NOT_SUPPORTED

return table.freeze(fs)