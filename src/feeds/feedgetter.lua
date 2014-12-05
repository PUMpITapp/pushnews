local http = require("socket.http")
local io = require("io")
local ltn12 = require("ltn12")
local SLAXML = require 'slaxdom'

require "feeds.feed"
require "feeds.xml"

local ignoreLinksRegx = {"quiz.svd.se", "cnn.com/video"}


FeedGetter = {}
FeedGetter.__index = FeedsGetter

function FeedGetter:new()
	newObj = {
		
	}
  self.__index = self
  return setmetatable(newObj, self)
end

--- Download or refactor the feed
-- @param url The url
-- @param filename What you want to name the file
function FeedGetter:downloadFeeds(url, filename)
	local outputfile = io.open(filename, "w+")

	http.request { 
    url = url, 
    sink = ltn12.sink.file(outputfile)
	}

	--should be triggered after the http request, 
	--io.close(outputfile)

end

--- Parse the feed
-- @param file File to take the feeds from
-- @return parsed An array containing the feeds
function FeedGetter:parseFeeds(filename)
	local xml = io.open(filename):read('*all')

	--deleting everything after the end rss tag, causing parsing errors
	local beg, found = string.find(xml, '</rss>')
	xml = string.sub(xml, 1, found)

	local doc = SLAXML:dom(xml)

	local channel = XML.getByName(doc.root, 'channel')[1]
	local items = XML.getByName(channel, 'item')

	local feeds = {}

	local first = true


	for i, item in ipairs(items) do

		local title = XML.elementText(XML.getByName(item, 'title')[1])
		local descr = XML.elementText(XML.getByName(item, 'description')[1])
		local date = XML.elementText(XML.getByName(item, 'pubDate')[1])
		local link = XML.elementText(XML.getByName(item, 'guid')[1]) 
		if string.find(link, "http://travel.cnn.com") ~= nil then
			link = XML.elementText(XML.getByName(item, 'link')[1])
		end
		local images = {}

		for i, imgElement in ipairs(XML.getByName(item, 'thumbnail')) do
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

			for i, existingFeed in ipairs(feeds) do
				if existingFeed.title == title then
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
