download = {}
download.__index = download

local http = require("socket.http")
local io = require("io")
local ltn12 = require("ltn12")

--- Download the file
-- @param url The url
-- @param filename What you want to name your file
function download.downloadFile(url, filename)
  local outputfile = io.open(filename, "w+")

  http.request { 
    url = url, 
    sink = ltn12.sink.file(outputfile)
  }

end