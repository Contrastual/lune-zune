local serde = {}

local utilfunc = require("../utils/func")

local z = zune.serde

local encoders = {
  json = function(value, pretty)
    return z.json.encode(value, {pretty_indent = pretty and math.huge or 0})
  end,
  yaml = function(value, pretty)
    return z.yaml.encode(value)
  end,
  toml = function(value, pretty)
    return z.toml.encode(value)
  end
}

local compressors = {
  brotli = function(s, level)
    return z.brotli.compress(s, {level = type(level) == "number" and level or nil})
  end,
  gzip = function(s, level)
    return z.gzip.compress(s, {level = type(level) == "number" and level or nil})
  end,
  lz4 = function(s, level)
    return z.lz4.compress(s, {level = type(level) == "number" and level or nil})
  end,
  zlib = function(s, level)
    return z.zlib.compress(s, {level = type(level) == "number" and level or nil})
  end,
  zstd = function(s, level)
    return z.zstd.compress(s, {level = type(level) == "number" and level or nil})
  end
}

export type EncodeDecodeFormat = "json" | "yaml" | "toml"
export type CompressDecompressFormat = "brotli" | "gzip" | "lz4" | "zlib" | "zstd"

function serde.encode(format: EncodeDecodeFormat, value: string, pretty: boolean?)
  if encoders[format] then
    return encoders[format](value, pretty)
  end
  error("unsupported format", 2)
end

function serde.decode(format: EncodeDecodeFormat, encoded: string)
  if encoders[format] then
    return z[format].decode(encoded)
  end
  error("unsupported format", 2)
end

function serde.compress(format: CompressDecompressFormat, s: string, level: number?)
  if compressors[format] then
    return compressors[format](s, level)
  end
  error("unsupported format", 2)
end

function serde.decompress(format: EncodeDecodeFormat, encoded: string)
  if compressors[format] then
    return z[format].decompress(encoded)
  end
  error("unsupported format", 2)
end

serde.hash = utilfunc.THROW_NOT_SUPPORTED
serde.hmac = utilfunc.THROW_NOT_SUPPORTED

return table.freeze(serde)