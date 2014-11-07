local http = require("socket.http")
local io = require("io")
local ltn12 = require("ltn12")
require "feeds.feed"

FeedGetter = {}
FeedGetter.__index = FeedsGetter

function FeedGetter:new()
	newObj = {
		
	}
  self.__index = self
  return setmetatable(newObj, self)
end

function FeedGetter:downloadFeeds(url, filename)
	local outputfile = io.open(filename, "w+")

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

	local parsed = {
		entries = {
			{title = "War: What is it good for?", summary = "The West is bombing terror group ISIS in Syria and Iraq, while Russia is engaged in a brittle stand-off in Eastern Ukraine. Bloodshed has dominated headlines through summer but, amid the misery, there is a winner: The defense industry.", updated = "Fri, 10 Oct 2014 07:23:34 EDT", id = "http://edition.cnn.com/2014/10/10/business/war-economy/index.html", image = "http://feeds.feedburner.com/~r/rss/edition_europe/~4/Ds3zG0DN0t4", source = "CNN"},
			{title = "War: What is it good for?", summary = "The West is bombing terror group ISIS in Syria and Iraq, while Russia is engaged in a brittle stand-off in Eastern Ukraine. Bloodshed has dominated headlines through summer but, amid the misery, there is a winner: The defense industry.", updated = "Fri, 10 Oct 2014 07:23:34 EDT", id = "http://edition.cnn.com/2014/10/10/business/war-economy/index.html", image = "http://feeds.feedburner.com/~r/rss/edition_europe/~4/Ds3zG0DN0t4", source = "CNN"},
			{title = "War: What is it good for?", summary = "The West is bombing terror group ISIS in Syria and Iraq, while Russia is engaged in a brittle stand-off in Eastern Ukraine. Bloodshed has dominated headlines through summer but, amid the misery, there is a winner: The defense industry.", updated = "Fri, 10 Oct 2014 07:23:34 EDT", id = "http://edition.cnn.com/2014/10/10/business/war-economy/index.html", image = "http://feeds.feedburner.com/~r/rss/edition_europe/~4/Ds3zG0DN0t4", source = "CNN"},
			{title = "Keeping Ebola away from humans", summary = "The West is bombing terror group ISIS in Syria and Iraq, while Russia is engaged in a brittle stand-off in Eastern Ukraine. Bloodshed has dominated headlines through summer but, amid the misery, there is a winner: The defense industry.", updated = "Fri, 10 Oct 2014 06:52:22 EDT", id = "http://edition.cnn.com/2014/10/09/opinion/osofsky-ebola-wildlife/index.html", image = "http://feeds.feedburner.com/~r/rss/edition_europe/~4/Ac87-SjauYU", source = "CNN"},
			{title = "Keeping Ebola away from humans", summary = "The West is bombing terror group ISIS in Syria and Iraq, while Russia is engaged in a brittle stand-off in Eastern Ukraine. Bloodshed has dominated headlines through summer but, amid the misery, there is a winner: The defense industry.", updated = "Fri, 10 Oct 2014 06:52:22 EDT", id = "http://edition.cnn.com/2014/10/09/opinion/osofsky-ebola-wildlife/index.html", image = "http://feeds.feedburner.com/~r/rss/edition_europe/~4/Ac87-SjauYU", source = "CNN"},
			{title = "Keeping Ebola away from humans", summary = "The West is bombing terror group ISIS in Syria and Iraq, while Russia is engaged in a brittle stand-off in Eastern Ukraine. Bloodshed has dominated headlines through summer but, amid the misery, there is a winner: The defense industry.", updated = "Fri, 10 Oct 2014 06:52:22 EDT", id = "http://edition.cnn.com/2014/10/09/opinion/osofsky-ebola-wildlife/index.html", image = "http://feeds.feedburner.com/~r/rss/edition_europe/~4/Ac87-SjauYU", source = "CNN"},
		}
	}

	return parsed
end

--Should result a simple array of feed from the output given by the feedparser library
function FeedGetter:translateResult(parsed, source)
	local feeds = {}

	for i, parsedFeed in ipairs(parsed.entries) do
 		feeds[i] = Feed:new(parsedFeed.title, parsedFeed.summary, parsedFeed.updated, parsedFeed.id, source, parsedFeed.image)
 	end

 	return feeds
end
