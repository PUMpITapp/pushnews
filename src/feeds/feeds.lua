local http = require("socket.http")
local io = require("io")
local ltn12 = require("ltn12")
require "feedparser"

FeedGetter = {}
FeedGetter.__index = FeedsGetter

function FeedGetter:new()
	newObj = {
		
	}
  self.__index = self
  return setmetatable(newObj, self)
end

function FeedGetter:downloadFeeds(url, filename)
	print(filename)

	outputfile = io.open(filename, "w+")

	http.request { 
    url = url, 
    sink = ltn12.sink.file(outputfile)
	}

	--should be triggered after the http request, 
	--io.close(outputfile)

end

function FeedGetter:parseFeeds(url, filename)
  local f = io.open(filename, "rb")
  local rss = f:read("*all")
  f:close()

	local parsed, err = feedparser.parse(rss, url)

	return parsed

end
