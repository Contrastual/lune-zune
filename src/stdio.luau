local stdio = {}
local utilfunc = require("../utils/func")

function stdio.prompt(kind: nil | "text" | "confirm" | "select" | "multiselect")
  if kind == "multiselect" then

  elseif kind == "select" then

  elseif kind == "confirm" then

  else

  end
end

stdio.color = utilfunc.THROW_NOT_SUPPORTED
stdio.style = utilfunc.THROW_NOT_SUPPORTED
stdio.format = utilfunc.THROW_NOT_SUPPORTED
stdio.write = utilfunc.THROW_NOT_SUPPORTED
stdio.ewrite = utilfunc.THROW_NOT_SUPPORTED
stdio.readLine = utilfunc.THROW_NOT_SUPPORTED
stdio.readToEnd = utilfunc.THROW_NOT_SUPPORTED

return table.freeze(stdio)