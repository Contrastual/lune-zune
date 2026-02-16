local serde = {}

local utilfunc = require("../utils/func")

local z = zune.serde

export type EncodeDecodeFormat = "json" | "yaml" | "toml"
export type CompressDecompressFormat = "brotli" | "gzip" | "lz4" | "zlib" | "zstd"
export type HashAlgorithm =
  "md5" | "sha1" | "sha" | "sha224" | "sha256" | "sha384" | "sha512" |
  "sha3-224" | "sha3-256" | "sha3-384" | "sha3-512" | "blake3"

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

local hashAlgorithms = {
  ["md5"] = "md5",
  ["sha1"] = "sha1",
  ["sha224"] = "sha224",
  ["sha256"] = "sha256",
  ["sha384"] = "sha384",
  ["sha512"] = "sha512",
  ["sha3-224"] = "sha3_224",
  ["sha3-256"] = "sha3_256",
  ["sha3-384"] = "sha3_384",
  ["sha3-512"] = "sha3_512",
  ["blake3"] = "blake3"
}

-- Encodes the given value using the given format.
function serde.encode(format: EncodeDecodeFormat, value: string, pretty: boolean?)
  if encoders[format] then
    return encoders[format](value, pretty)
  end
  error("unsupported format", 2)
end

-- Decodes the given string using the given format into a lua value.
function serde.decode(format: EncodeDecodeFormat, encoded: string)
  if encoders[format] then
    return z[format].decode(encoded)
  end
  error("unsupported format", 2)
end

-- Compresses the given string using the given format.
function serde.compress(format: CompressDecompressFormat, s: string, level: number?)
  if compressors[format] then
    return compressors[format](s, level)
  end
  error("unsupported format", 2)
end

-- Decompresses the given string using the given format.
function serde.decompress(format: EncodeDecodeFormat, encoded: string)
  if compressors[format] then
    return z[format].decompress(encoded)
  end
  error("unsupported format", 2)
end

-- Hashes the given message using the given algorithm and returns the hash as a hex string.
function serde.hash(algorithm: HashAlgorithm, message: string): string
  local zune_alias = hashAlgorithms[algorithm]
  if zune_alias then
    return zune.crypto.createHash(zune_alias):digest("hex")
  end
  error("unsupported algorithm", 2)
end

-- Hashes the given message using HMAC with the given secret and algorithm, returning the hash as a base64 string.
function serde.hmac(algorithm: HashAlgorithm, message: string, secret: string | buffer)
  local zune_alias = hashAlgorithms[algorithm]
  if not zune_alias then
    error("unsupported algorithm", 2)
  end
  
  local t = type(secret)
  if t == "buffer" then
    secret = buffer.tostring(secret)
  elseif t ~= "string" then
    error("bad secret type", 2)
  end

  return zune.crypto.createHash(zune_alias, secret):digest("base64")
end

return table.freeze(serde)