local roblox = {}
local utilfunc = require("../utils/func")

local luau_roblox = require("./luau-roblox")


--[[
Deserializes a place into a DataModel instance.

This function accepts a string of contents, not a file path.
If reading a place file from a file path is desired, `fs.readFile` can be used and the resulting string may be passed to this function.
]]
roblox.deserializePlace = luau_roblox.deserializePlace

--[[
Deserializes a model into an array of instances.

This function accepts a string of contents, not a file path.
If reading a model file from a file path is desired, `fs.readFile` can be used and the resulting string may be passed to this function.
]]
roblox.deserializeModel = luau_roblox.deserializeModel

--[[
Serializes a place from a DataModel instance.

This string can then be written to a file, or sent over the network.
]]
roblox.serializePlace = luau_roblox.serializePlace

--[[
Serializes one or more instances as a model.

This string can then be written to a file, or sent over the network.
]]
roblox.serializeModel = luau_roblox.serializeModel

--[[
lune-zune does not support this function.
]]
roblox.getAuthCookie = utilfunc.THROW_NOT_SUPPORTED

--[[
Gets the bundled reflection database.

This database contains information about Roblox enums, classes, and their properties.
]]
roblox.getReflectionDatabase = luau_roblox.getReflectionDatabase

--[[
Implements a property for all instances of the given className.

This takes into account class hierarchies, so implementing a property for the `BasePart` class will also implement it for `Part` and others,
unless a more specific implementation is added to the `Part` class directly.
]]
roblox.implementProperty = luau_roblox.manager.implementProperty

--[[
Implements a method for all instances of the given className.

This takes into account class hierarchies, so implementing a method for the `BasePart` class will also implement it for `Part` and others,
unless a more specific implementation is added to the `Part` class directly.
]]
roblox.implementMethod = luau_roblox.manager.implementMethod

--[[
lune-zune does not support this function.
]]
roblox.studioApplicationPath = utilfunc.THROW_NOT_SUPPORTED

--[[
lune-zune does not support this function.
]]
roblox.studioContentPath = utilfunc.THROW_NOT_SUPPORTED

--[[
lune-zune does not support this function.
]]
roblox.studioPluginPath = utilfunc.THROW_NOT_SUPPORTED

--[[
lune-zune does not support this function.
]]
roblox.studioBuiltinPluginPath = utilfunc.THROW_NOT_SUPPORTED

return table.freeze(roblox)