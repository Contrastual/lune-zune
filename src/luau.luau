--!nolint UnknownGlobal
--!nocheck

local luau = {}
local utilfunc = require("../utils/func")

export type CompileOptions = {
  optimizationLevel: number,
  coverageLevel: number,
  debugLevel: number,
}

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

luau.load = utilfunc.THROW_NOT_SUPPORTED

return table.freeze(luau)