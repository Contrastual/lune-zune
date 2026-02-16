--!nolint UnknownGlobal
--!nocheck

local luau = {}
local utilfunc = require("../utils/func")

export type CompileOptions = {
  optimizationLevel: number,
  coverageLevel: number,
  debugLevel: number,
}

--[[
Compiles sourcecode into Luau bytecode

An error will be thrown if the sourcecode given isn’t valid Luau code.
]]
function luau.compile(source: string, compileOptions: CompileOptions?)
  if type(compileOptions) ~= "table" then
    compileOptions = {}
  end
  
  return buffer.tostring(zune.luau.compile(source, {
    debug_level = compileOptions.debugLevel or 0,
    optimization_level = compileOptions.optimizationLevel or 1,
    coverage_level = compileOptions.coverageLevel or 0
  }))
end

--[[
lune-zune does not support this function.
]]
luau.load = utilfunc.THROW_NOT_SUPPORTED

return table.freeze(luau)