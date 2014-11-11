local http = require("socket.http")
local io = require("io")
local ltn12 = require("ltn12")
local SLAXML = require 'slaxdom'
require "feeds.feed"

function getByName(el, name)
	elements = {}

	for i, kid in ipairs (el.kids) do
		if kid.name == name then
			table.insert(elements, kid)
		end
	end

	return elements

end

function elementText(el)
  local pieces = {}
  for _,n in ipairs(el.kids) do
    if n.type=='element' then pieces[#pieces+1] = elementText(n)
    elseif n.type=='text' then pieces[#pieces+1] = n.value
    end
  end
  return table.concat(pieces)
end

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

	local xml = io.open(filename):read('*all')
	local doc = SLAXML:dom(xml)
	local channel = getByName(doc.root, 'channel')[1]
	local items = getByName(channel, 'item')

	local feeds = {}

	for i, item in ipairs(items) do

		local title = elementText(getByName(item, 'title')[1])
		local summary = elementText(getByName(item, 'description')[1])
		local date = elementText(getByName(item, 'pubDate')[1])
		local link = elementText(getByName(item, 'guid')[1])

		local image = nil

		--Insert the new feed
		table.insert(feeds, Feed:new(title, summary, date, link, image))
	end

	local parsed = {entries = feeds}

	return parsed
end
