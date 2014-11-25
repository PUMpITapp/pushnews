local http = require("socket.http")
local io = require("io")
local ltn12 = require("ltn12")
local SLAXML = require 'slaxdom'
require "feeds.feed"
require "feeds.xml"

local ignoreLinksRegx = {"quiz.svd.se"}


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

function FeedGetter:parseFeeds(filename)

	local xml = io.open(filename):read('*all')
	local doc = SLAXML:dom(xml)
	local channel = getByName(doc.root, 'channel')[1]
	local items = getByName(channel, 'item')

	local feeds = {}

	local first = true

	for i, item in ipairs(items) do

		local title = elementText(getByName(item, 'title')[1])
		local descr = elementText(getByName(item, 'description')[1])
		local date = elementText(getByName(item, 'pubDate')[1])
		local link = elementText(getByName(item, 'guid')[1])
		local images = {}

		for i, imgElement in ipairs(getByName(item, 'thumbnail')) do
			local url = imgElement.attr.url
			local width = tonumber(imgElement.attr.width)
			local height = tonumber(imgElement.attr.height)
			
			--do not use incomplete images

			if url ~= nil and width ~= nil and height ~= nil 
		 		 and url ~= '' and width > 0 and height > 0 then
				table.insert(images,{url = url, width = width, height = height})
			end

		end

		local b, e = descr:find("<img")

		--remove img tags for some descriptions
		if b ~= nil then
			descr = descr:sub(1, b - 1)
		end

		--do not use incomplete feeds

		if title ~= nil and title ~= '' and descr ~= nil and descr ~= ''
		and date ~= nil and date ~= '' and link ~= nil and link ~= '' then
			--filter for some particular links
			
			local good = true
			for i, IgnoreLink in ipairs(ignoreLinksRegx) do
				if string.find(link, IgnoreLink) ~= nil then
					good = false
				end
			end

			if good then				
			--Insert the new feed
			table.insert(feeds, Feed:new(title, descr, date, link, images))
			end

		end

		

	end

	local parsed = {entries = feeds}

	return parsed
end
