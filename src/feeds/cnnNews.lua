local http = require("socket.http")
local io = require("io")
local ltn12 = require("ltn12")
local SLAXML = require 'slaxdom'

require 'feeds.htmlLib'
require 'feeds.download'

sys = {}
sys.root_path = function () return '' end
local articleFile = sys.root_path() .. "feeds/article.html"

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

function CNNNews:new()
	newObj = {
		name = "CNN",
		advertising = false,
		datePattern = "%a+, (%d+) (%a+) (%d+) (%d+):(%d+):(%d+) (%a+)",
    image = "images/cnn.png",
		categories = {
			['Top stories'] = 'http://rss.cnn.com/rss/edition.rss',
			['World'] = 'http://rss.cnn.com/rss/edition_world.rss',
			['africa'] = 'http://rss.cnn.com/rss/edition_africa.rss',
			['americas'] = 'http://rss.cnn.com/rss/edition_americas.rss',
			['asia'] = 'http://rss.cnn.com/rss/edition_asia.rss',
			['Europe'] = 'http://rss.cnn.com/rss/edition_europe.rss',
			['meast'] = 'http://rss.cnn.com/rss/edition_meast.rss',
			['us'] = 'http://rss.cnn.com/rss/edition_us.rss',
			['Finance'] = 'http://rss.cnn.com/rss/money_news_international.rss',
			['Technology'] = 'http://rss.cnn.com/rss/edition_technology.rss',
			['space'] = 'http://rss.cnn.com/rss/edition_space.rss',
			['Entertainment'] = 'http://rss.cnn.com/rss/edition_entertainment.rss',
			['Sports'] = 'http://rss.cnn.com/rss/edition_sport.rss',
			['football'] = 'http://rss.cnn.com/rss/edition_football.rss',
			['golf'] = 'http://rss.cnn.com/rss/edition_golf.rss',
			['motor'] = 'http://rss.cnn.com/rss/edition_motorsport.rss',
			['tennis'] = 'http://rss.cnn.com/rss/edition_tennis.rss',
			['latest'] = 'http://rss.cnn.com/rss/cnn_latest.rss'
		}
	}
  self.__index = self
  return setmetatable(newObj, self)
end

function CNNNews:parseArticleFile(articleFile)
	local htmlstr = io.open(articleFile):read('*all')
	
	local html = require 'html'

  local root = html.parsestr(htmlstr)
  
  local block = HTML.findClass(root, 'cnn_storyarea')

  if #block == 0 then
  	block = HTML.findClass(root, 'cnnContentContainer')
  end
  if #block == 0 then
  	block = HTML.findId(root, 'storytext')
  end

  if block == nil then
  	block = {}
  end
	
	local paragraphs = HTML.findTag(block, 'p')

	local text = HTML.getText (paragraphs)

	return text

end

function CNNNews:getArticleText(link)
	download.downloadFile(link, articleFile)

	return self:parseArticleFile(articleFile)

end
