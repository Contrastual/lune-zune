--!nolint UnknownGlobal
--!nocheck

local fs = {}
local utilfunc = require("../utils/func")

--[[
Reads a file at `path`.

An error will be thrown in the following situations:

- `path` does not point to an existing file.
- The current process lacks permissions to read the file.
- Some other I/O error occurred.
]]
function fs.readFile(path: string): string
  return zune.fs.readFile(path, false)
end

--[[
Reads entries in a directory at `path`.

An error will be thrown in the following situations:

- `path` does not point to an existing directory.
- The current process lacks permissions to read the contents of the directory.
- Some other I/O error occurred.
]]
function fs.readDir(path: string)
  local ret = {}
  local filenames = zune.fs.entries(path)
  for _, file in filenames do
    table.insert(ret, file)
  end
  table.sort(ret)
  return ret
end

--[[
Writes to a file at `path`.

An error will be thrown in the following situations:

- The file’s parent directory does not exist.
- The current process lacks permissions to write to the file.
- Some other I/O error occurred.
]]
function fs.writeFile(path: string, contents: string)
  zune.fs.writeFile(path, contents)
end

--[[
Creates a directory and its parent directories if they are missing.

An error will be thrown in the following situations:

- `path` already points to an existing file or directory.
- The current process lacks permissions to create the directory or its missing parents.
- Some other I/O error occurred.
]]
function fs.writeDir(path: string)
  zune.fs.makeDir(path, true)
end

--[[
Removes a file.

An error will be thrown in the following situations:

- `path` does not point to an existing file.
- The current process lacks permissions to remove the file.
- Some other I/O error occurred.
]]
fs.removeFile = zune.fs.deleteFile

function fs.removeDir(path: string)
  zune.fs.deleteDir(path, true)
end

--[[
lune-zune does not support this function.
]]
fs.metadata = utilfunc.THROW_NOT_SUPPORTED

--[[
Checks if a given path is a file.

An error will be thrown in the following situations:

- The current process lacks permissions to read at `path`.
- Some other I/O error occurred.
]]
function fs.isFile(path: string)
  local s, metadata: Metadata = pcall(zune.fs.metadata, path)
  if not s then return false end
  return metadata.kind == "file"
end

--[[
Checks if a given path is a directory.

An error will be thrown in the following situations:

- The current process lacks permissions to read at `path`.
- Some other I/O error occurred.
]]
function fs.isDir(path: string)
  local s, metadata: Metadata = pcall(zune.fs.metadata, path)
  if not s then return false end
  return metadata.kind == "directory" or metadata.kind == "sym_link"
end

--[[
lune-zune does not support this function.
]]
fs.move = utilfunc.THROW_NOT_SUPPORTED

--[[
lune-zune does not support this function.
]]
fs.copy = utilfunc.THROW_NOT_SUPPORTED

return table.freeze(fs)