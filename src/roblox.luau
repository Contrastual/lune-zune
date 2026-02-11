local roblox = {}
local utilfunc = require("../utils/func")

print("Initializing luau-roblox")
local luau_roblox = require("../extern/luau-roblox/src")

roblox.deserializePlace = luau_roblox.deserializePlace
roblox.deserializeModel = luau_roblox.deserializeModel
roblox.serializePlace = luau_roblox.serializePlace
roblox.serializeModel = luau_roblox.serializeModel
roblox.getAuthCookie = utilfunc.THROW_NOT_SUPPORTED
roblox.getReflectionDatabase = luau_roblox.getReflectionDatabase
roblox.implementProperty = luau_roblox.manager.implementProperty
roblox.implementMethod = luau_roblox.manager.implementMethod
roblox.studioApplicationPath = utilfunc.THROW_NOT_SUPPORTED
roblox.studioContentPath = utilfunc.THROW_NOT_SUPPORTED
roblox.studioPluginPath = utilfunc.THROW_NOT_SUPPORTED
roblox.studioBuiltinPluginPath = utilfunc.THROW_NOT_SUPPORTED

return table.freeze(roblox)