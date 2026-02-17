local stdio = {}
local utilfunc = require("../utils/func")

--[[
lune-zune does not support this function.
]]
function stdio.prompt(kind: nil | "text" | "confirm" | "select" | "multiselect")
  if kind == "multiselect" then

  elseif kind == "select" then

  elseif kind == "confirm" then

  else

  end
end

--[[
lune-zune does not support this function.
]]
stdio.color = utilfunc.THROW_NOT_SUPPORTED

--[[
lune-zune does not support this function.
]]
stdio.style = utilfunc.THROW_NOT_SUPPORTED

--[[
lune-zune does not support this function.
]]
stdio.format = utilfunc.THROW_NOT_SUPPORTED

--[[
lune-zune does not support this function.
]]
stdio.write = utilfunc.THROW_NOT_SUPPORTED

--[[
lune-zune does not support this function.
]]
stdio.ewrite = utilfunc.THROW_NOT_SUPPORTED

--[[
lune-zune does not support this function.
]]
stdio.readLine = utilfunc.THROW_NOT_SUPPORTED

--[[
lune-zune does not support this function.
]]
stdio.readToEnd = utilfunc.THROW_NOT_SUPPORTED

return table.freeze(stdio)