--!strict
local roblox = require("@self/roblox");
local binary = require("@self/binary");
local xml = require("@self/xml");

export type DOM = roblox.Document;
export type DOMInfo = roblox.DocumentInfo;
export type DOMClass = roblox.Class;
export type DOMInstance = roblox.Instance;
export type DOMProperty = roblox.Property;

local BINARY_HEADER_LEN = #binary.header;

local dom = {};

dom.roblox = roblox;

function dom.deserialize(data: string | buffer): roblox.Document
    if (type(data) == "string") then
        data = buffer.fromstring(data);
    end
    assert(type(data) == "buffer", "Internal DOM Error");

    if type(data) == "buffer" then
        if buffer.len(data) > 7 then
            if buffer.readstring(data, 0, 7) == "<roblox" then
                local header7 = buffer.readstring(data, 7, 1)
                if header7 == "!" then
                    -- Binary
                    return binary.deserialize(data, BINARY_HEADER_LEN);
                elseif header7 == "" then
                    -- XML
                    return xml.deserialize(data);
                end
            end
        end
    end

    error("Internal DOM Error")
end

function dom.serialize(document: roblox.Document, format: ("XML" | "BINARY")?): buffer
    format = format or "BINARY";
    if (format == "BINARY") then
        return binary.serialize(document);
    else
        return xml.serialize(document);
    end
end

function dom.setDebugCallback(format: "XML" | "BINARY", callback: (...any) -> ()): ()
    format = format or "BINARY";
    if (format == "BINARY") then
        binary.debug(callback);
    else
        xml.debug(callback);
    end
end

return dom;
