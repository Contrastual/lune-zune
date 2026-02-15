# Lune compatibility layer for Zune
This is a compatibility layer for the Lune runtime's standard library to be used in Zune 0.5.2 (support for 0.5.1 and 0.5.0 is not guaranteed). Designed for Lune 0.10.4

## Library support

If the API is supported, it will have one of two statuses:
- `native`: the Zune API is used directly without abstraction
- `emulated`: re-implementation of the API

| Library/Object     | Name                              | Implementation |
|--------------------|-----------------------------------|----------------|
| <b>datetime</b>    | .now()                            | ❌ |
|                    | .fromUnixTimestamp()              | ❌ |
|                    | .fromUniversalTime()              | ❌ |
|                    | .fromLocalTime()                  | ❌ |
|                    | .fromIsoDate()                    | ❌ |
|                    | .fromRfc3339()                    | ❌ |
|                    | .fromRfc2822()                    | ❌ |
|                    | .fromUnixTimestamp()              | ❌ |
| DateTime           | .unixTimestamp                    | ❌ |
|                    | .unixTimestampMillis              | ❌ |
|                    | :formatLocalTime                  | ❌ |
|                    | :formatUniversalTime              | ❌ |
|                    | :toIsoDate                        | ❌ |
|                    | :toRfc2822                        | ❌ |
|                    | :toRfc3339                        | ❌ |
|                    | :toLocalTime                      | ❌ |
|                    | :toUniversalTime                  | ❌ |
|||||
| <b>fs</b>          | readFile                          | ✅ emulated |
|                    | readDir                           | ✅ emulated |
|                    | writeFile                         | ✅ emulated |
|                    | writeDir                          | ✅ emulated |
|                    | removeFile                        | ❌ |
|                    | removeDir                         | ❌ |
|                    | metadata                          | ❌ |
|                    | isFile                            | ❌ |
|                    | isDir                             | ✅ emulated |
|                    | move                              | ❌ |
|                    | copy                              | ❌ |
|||||
| <b>luau</b>        | .compile()                        | ✅ emulated |
|                    | .load()                           | ✅ emulated |
|||||
| <b>net</b>         | .request()                        | ✅ emulated |
|                    | .socket()                         | ❌ |
|                    | .urlEncode()                      | ✅ emulated |
|                    | .urlDecode()                      | ❌ |
| Tcp                | :connect()                        | ❌ |
| TcpStream          | :read()                           | ❌ |
|                    | :write()                          | ❌ |
|                    | :close()                          | ❌ |
|||||
| <b>process</b>     | .os                               | ✅ <b>native</b> |
|                    | .arch                             | ✅ <b>native</b> |
|                    | .endianness                       | ✅ <b>native</b> |
|                    | .arg                              | ❌ |
|                    | .cwd                              | ❌ |
|                    | .env                              | ✅ <b>native</b> |
|                    | .exit()                           | ❌ |
|                    | .create()                         | ❌ |
|                    | .spec()                           | ❌ |
| ChildProcessReader | .read()                           | ❌ |
|                    | .readToEnd()                      | ❌ |
| ChildProcessWriter | .write()                          | ❌ |
|                    | .close()                          | ❌ |
|||||
| <b>regex</b>       | .new()                            | ❌ |
| Regex              | :isMatch()                        | ❌ |
|                    | :find()                           | ❌ |
|                    | :captures()                       | ❌ |
|                    | :split()                          | ❌ |
|                    | :replace()                        | ❌ |
|                    | :replaceAll()                     | ❌ |
|||||
| <b>roblox</b>      | .deserializePlace()               | ✅ emulated |
|                    | .deserializeModel()               | ✅ emulated |
|                    | .serializePlace()                 | ✅ emulated |
|                    | .serializeModel()                 | ✅ emulated |
|                    | .getAuthCookie()                  | ❌ |
|                    | .getReflectionDatabase()          | ✅ emulated |
|                    | .implementProperty()              | ✅ emulated |
|                    | .implementMethod()                | ✅ emulated |
|                    | .studioApplicationPath()          | ❌ |
|                    | .studioContentPath()              | ❌ |
|                    | .studioApplicatstudioPluginPath() | ❌ |
|                    | .studioBuiltinPluginPath()        | ❌ |
|||||
| <b>serde</b>       | .encode()                         | ✅ emulated |
|                    | .decode()                         | ✅ emulated |
|                    | .compress()                       | ✅ emulated |
|                    | .decompress()                     | ✅ emulated |
|                    | .hash()                           | ❌ |
|                    | .hmac()                           | ❌ |
|||||
| <b>stdio</b>       | .prompt()                         | ❌ |
|                    | .color()                          | ❌ |
|                    | .style()                          | ❌ |
|                    | .format()                         | ❌ |
|                    | .write()                          | ❌ |
|                    | .ewrite()                         | ❌ |
|                    | .readLine()                       | ❌ |
|                    | .readToEnd()                      | ❌ |
|||||
| <b>task</b>        | .cancel()                         | ✅ <b>native</b> |
|                    | .spawn()                          | ✅ <b>native</b> |
|                    | .defer()                          | ✅ <b>native</b> |
|                    | .delay()                          | ✅ <b>native</b> |
|                    | .wait()                           | ✅ <b>native</b> |

## Setup
Replace the `lune` alias on the `.luaurc` file located on the root directory of your program with the path to the `src` folder and remove all alias overrides of `lune` on subdirectories.

```json
{
  "aliases": {
    "lune": "path/to/lune-zune/src",
  }
}
```