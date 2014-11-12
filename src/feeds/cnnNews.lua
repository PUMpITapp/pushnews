local http = require("socket.http")
local io = require("io")
local ltn12 = require("ltn12")
local SLAXML = require 'slaxdom'

local articleFile = "feeds/article.html"

CNNNews = {}
CNNNews.__index = CNNNews

function getParagraphs(elements)
	local t = {}
	for i, e in pairs(elements) do
		if e._tag == 'p' and e._attr.class and string.find(e._attr.class, "cnn_storypgraphtxt") ~= nil then
			table.insert(t, e)
		elseif e ~= nil and type(e) == 'table' then

			local other = getParagraphs(e)

			for k, o in ipairs(other) do
				table.insert (t, o)
			end
		end
	end

	return t
end

function getText(paragraphs)
	local str = ''

	for i, p in ipairs(paragraphs) do
		if type(p) == 'table' then
			str = str .. getText(p) .. ' '
		else
			str = str .. p
		end
	end

	return str

end

function CNNNews:new()
	newObj = {
		categories = {
			top = 'http://rss.cnn.com/rss/edition.rss',
			world = 'http://rss.cnn.com/rss/edition_world.rss',
			africa = 'http://rss.cnn.com/rss/edition_africa.rss',
			americas = 'http://rss.cnn.com/rss/edition_americas.rss',
			asia = 'http://rss.cnn.com/rss/edition_asia.rss',
			europe = 'http://rss.cnn.com/rss/edition_europe.rss',
			meast = 'http://rss.cnn.com/rss/edition_meast.rss',
			us = 'http://rss.cnn.com/rss/edition_us.rss',
			money = 'http://rss.cnn.com/rss/money_news_international.rss',
			techno = 'http://rss.cnn.com/rss/edition_technology.rss',
			space = 'http://rss.cnn.com/rss/edition_space.rss',
			entertainment = 'http://rss.cnn.com/rss/edition_entertainment.rss',
			sports = 'http://rss.cnn.com/rss/edition_sport.rss',
			football = 'http://rss.cnn.com/rss/edition_football.rss',
			golf = 'http://rss.cnn.com/rss/edition_golf.rss',
			motor = 'http://rss.cnn.com/rss/edition_motorsport.rss',
			tennis = 'http://rss.cnn.com/rss/edition_tennis.rss',
			latest = 'http://rss.cnn.com/rss/cnn_latest.rss'
		}
	}
  self.__index = self
  return setmetatable(newObj, self)
end

function CNNNews:downloadArticle (link, output)
	local outputfile = io.open(output, "w+")

	http.request { 
    url = link, 
    sink = ltn12.sink.file(outputfile)
	}

end

function CNNNews:parseArticleFile(articleFile)
	local htmlstr = io.open(articleFile):read('*all')
	
	local html = require 'html'

  local root = html.parsestr(htmlstr)
	
	local paragraphs = getParagraphs(root)

	local text = getText (paragraphs)

	return text

end

function CNNNews:getArticleText(link)
	self:downloadArticle(articleFile, articleFile)

	return self:parseArticleFile(articleFile)

end