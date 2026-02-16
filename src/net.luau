--!nolint UnknownGlobal
--!nocheck

local net = {}
local utilfunc = require("../utils/func")

export type ServeConfig = {
  address: string?,
  handleRequest: (() -> ServeResponse)?,
  handleWebSocket: (() -> ())?
}

export type ServeResponse = {
  status: number,
  headers: {[string]: any},
  body: string
}

export type FetchParams = {
  url: string,
  method: string | "GET",
  body: string,
  query: {[string]: string},
  headers: {[string]: string},
  options: {[string]: any}
}

export type FetchResponse = {
  ok: boolean,
  statusCode: number,
  statusMessage: string,
  headers: {[string]: string},
  body: string
}

local url_encode
local url_encode_coverage = "["

local MAX_BODY_SIZE = 1024 * 1024 * 16

local function dourlenc(s)
  return string.gsub(s, url_encode_coverage, function(s)
    return url_encode[s]
  end)
end

local proto_TcpStream = {}
proto_TcpStream.__index = proto_TcpStream
proto_TcpStream.__metatable = "This metatable is locked"

proto_TcpStream.read = utilfunc.THROW_NOT_SUPPORTED
proto_TcpStream.write = utilfunc.THROW_NOT_SUPPORTED
proto_TcpStream.close = utilfunc.THROW_NOT_SUPPORTED

table.freeze(proto_TcpStream)

function net.request(config: FetchParams): FetchResponse
  local url = config.url
  if not url then
    error("no url", 2)
  end

  local method = config.method or "GET"
  local body = config.body or ""
  local headers = config.headers or {}
  local options = config.options or {}

  local query = config.query or {}
  if next(query) and not string.match(url, "%?$") then
    url ..= "?"
  end
  local url_add = {}
  for name, value in next, query do
    table.insert(url_add, string.format("%s=%s", dourlenc(name), dourlenc(tostring(value))))
  end
  
  -- print(config)
  local res = zune.net.http.request(url, {
    headers = headers,
    method = method,
    body = body,
    allow_redirects = true,
    max_body_size = MAX_BODY_SIZE
  })

  while res.headers.location do
    res = zune.net.http.request(res.headers.location, {
      headers = headers,
      method = method,
      body = body,
      allow_redirects = true,
      max_body_size = MAX_BODY_SIZE
    })
  end
  -- print(res)

  return {
    ok = res.ok,
    statusCode = res.status_code,
    statusMessage = res.status_reason,
    headers = res.headers,
    body = res.body
  }
end

net.socket = utilfunc.THROW_NOT_SUPPORTED

local function createHttpHandler(lune_handler)
  return function(req)
    -- print(req)
    local lune_response = lune_handler({
      path = req.path or "/",
      query = req.query or {},
      method = req.method,
      headers = req.headers or {},
      body = req.body or ""
    })

    local res = lune_response and {
      status_code = lune_response.status or 404,
      headers = lune_response.headers,
      body = if lune_response.status then lune_response.body or "" else "Not Found"
    } or {status_code = 400}
    return res
  end
end

function net.serve(port: number, handlerOrConfig: () -> () | ServeConfig)
  local config = {
    port = port,
    backlog = 0
  }

  if type(handlerOrConfig) == "function" then
    config.request = createHttpHandler(handlerOrConfig)
  elseif type(handlerOrConfig) == "table" then
    if handlerOrConfig.handleRequest then
      config.request = createHttpHandler(handlerOrConfig.handleRequest)
    end
    if handlerOrConfig.handleWebSocket then
      -- config.websocket = createWSHandler(handlerOrConfig.handleWebSocket)
    end
    config.address = handlerOrConfig.address
  end

  local httpServer = zune.net.http.serve(config)

  return table.freeze({
    stop = function()
      httpServer:stop()
    end
  })
end

net.urlEncode = utilfunc.THROW_NOT_SUPPORTED
net.urlDecode = utilfunc.THROW_NOT_SUPPORTED

url_encode = {
  [' '] = "%20",
  ['!'] = "%21",
  ['"'] = "%22",
  ['#'] = "%23",
  ['$'] = "%24",
  ['%'] = "%25",
  ['&'] = "%26",
  ["'"] = "%27",
  ['('] = "%28",
  [')'] = "%29",
  ['*'] = "%2A",
  ['+'] = "%2B",
  [','] = "%2C",
  ['-'] = "%2D",
  ['.'] = "%2E",
  ['/'] = "%2F",
  [':'] = "%3A",
  [';'] = "%3B",
  ['<'] = "%3C",
  ['='] = "%3D",
  ['>'] = "%3E",
  ['?'] = "%3F",
  ['@'] = "%40",
  ['['] = "%5B",
  ['\\'] = "%5C",
  [']'] = "%5D",
  ['^'] = "%5E",
  ['_'] = "%5F",
  ['`'] = "%60",
  ['{'] = "%7B",
  ['|'] = "%7C",
  ['}'] = "%7D",
  ['~'] = "%7E",
  ["\x7f"] = "%7F",
  ['€'] = "%E2%82%AC",
  [''] = "%81",
  ['‚'] = "%E2%80%9A",
  ['ƒ'] = "%C6%92",
  ['„'] = "%E2%80%9E",
  ['…'] = "%E2%80%A6",
  ['†'] = "%E2%80%A0",
  ['‡'] = "%E2%80%A1",
  ['ˆ'] = "%CB%86",
  ['‰'] = "%E2%80%B0",
  ['Š'] = "%C5%A0",
  ['‹'] = "%E2%80%B9",
  ['Œ'] = "%C5%92",
  [''] = "%C5%8D",
  ['Ž'] = "%C5%BD",
  [''] = "%8F",
  [''] = "%C2%90",
  ['‘'] = "%E2%80%98",
  ["'"] = "%E2%80%99",
  ['“'] = "%E2%80%9C",
  ['”'] = "%E2%80%9D",
  ['•'] = "%E2%80%A2",
  ['–'] = "%E2%80%93",
  ['—'] = "%E2%80%94",
  ['˜'] = "%CB%9C",
  ['™'] = "%E2%84",
  ['š'] = "%C5%A1",
  ['›'] = "%E2%80",
  ['œ'] = "%C5%93",
  [''] = "%9D",
  ['ž'] = "%C5%BE",
  ['Ÿ'] = "%C5%B8",
  ['\xc2\xa0'] = "%C2%A0",
  ['¡'] = "%C2%A1",
  ['¢'] = "%C2%A2",
  ['£'] = "%C2%A3",
  ['¤'] = "%C2%A4",
  ['¥'] = "%C2%A5",
  ['¦'] = "%C2%A6",
  ['§'] = "%C2%A7",
  ['¨'] = "%C2%A8",
  ['©'] = "%C2%A9",
  ['ª'] = "%C2%AA",
  ['«'] = "%C2%AB",
  ['¬'] = "%C2%AC",
  ['­'] = "%C2%AD",
  ['®'] = "%C2%AE",
  ['¯'] = "%C2%AF",
  ['°'] = "%C2%B0",
  ['±'] = "%C2%B1",
  ['²'] = "%C2%B2",
  ['³'] = "%C2%B3",
  ['´'] = "%C2%B4",
  ['µ'] = "%C2%B5",
  ['¶'] = "%C2%B6",
  ['·'] = "%C2%B7",
  ['¸'] = "%C2%B8",
  ['¹'] = "%C2%B9",
  ['º'] = "%C2%BA",
  ['»'] = "%C2%BB",
  ['¼'] = "%C2%BC",
  ['½'] = "%C2%BD",
  ['¾'] = "%C2%BE",
  ['¿'] = "%C2%BF",
  ['À'] = "%C3%80",
  ['Á'] = "%C3%81",
  ['Â'] = "%C3%82",
  ['Ã'] = "%C3%83",
  ['Ä'] = "%C3%84",
  ['Å'] = "%C3%85",
  ['Æ'] = "%C3%86",
  ['Ç'] = "%C3%87",
  ['È'] = "%C3%88",
  ['É'] = "%C3%89",
  ['Ê'] = "%C3%8A",
  ['Ë'] = "%C3%8B",
  ['Ì'] = "%C3%8C",
  ['Í'] = "%C3%8D",
  ['Î'] = "%C3%8E",
  ['Ï'] = "%C3%8F",
  ['Ð'] = "%C3%90",
  ['Ñ'] = "%C3%91",
  ['Ò'] = "%C3%92",
  ['Ó'] = "%C3%93",
  ['Ô'] = "%C3%94",
  ['Õ'] = "%C3%95",
  ['Ö'] = "%C3%96",
  ['×'] = "%C3%97",
  ['Ø'] = "%C3%98",
  ['Ù'] = "%C3%99",
  ['Ú'] = "%C3%9A",
  ['Û'] = "%C3%9B",
  ['Ü'] = "%C3%9C",
  ['Ý'] = "%C3%9D",
  ['Þ'] = "%C3%9E",
  ['ß'] = "%C3%9F",
  ['à'] = "%C3%A0",
  ['á'] = "%C3%A1",
  ['â'] = "%C3%A2",
  ['ã'] = "%C3%A3",
  ['ä'] = "%C3%A4",
  ['å'] = "%C3%A5",
  ['æ'] = "%C3%A6",
  ['ç'] = "%C3%A7",
  ['è'] = "%C3%A8",
  ['é'] = "%C3%A9",
  ['ê'] = "%C3%AA",
  ['ë'] = "%C3%AB",
  ['ì'] = "%C3%AC",
  ['í'] = "%C3%AD",
  ['î'] = "%C3%AE",
  ['ï'] = "%C3%AF",
  ['ð'] = "%C3%B0",
  ['ñ'] = "%C3%B1",
  ['ò'] = "%C3%B2",
  ['ó'] = "%C3%B3",
  ['ô'] = "%C3%B4",
  ['õ'] = "%C3%B5",
  ['ö'] = "%C3%B6",
  ['÷'] = "%C3%B7",
  ['ø'] = "%C3%B8",
  ['ù'] = "%C3%B9",
  ['ú'] = "%C3%BA",
  ['û'] = "%C3%BB",
  ['ü'] = "%C3%BC",
  ['ý'] = "%C3%BD",
  ['þ'] = "%C3%BE",
  ['ÿ'] = "%C3%BF",
}

for s in next, url_encode do
  url_encode_coverage ..= string.gsub(s, "([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1")
end

url_encode_coverage ..= "]"

return table.freeze(net)