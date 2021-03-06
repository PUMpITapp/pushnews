local http = require("socket.http")
local io = require("io")
local ltn12 = require("ltn12")
local SLAXML = require 'slaxdom'

require 'config'
require 'feeds.htmlLib'
require 'feeds.download'

--to run app on box
if runningOnBox == false then
  sys = {}
  sys.root_path = function () return '' end
end
local articleFile = sys.root_path() .. "feeds/article.html"

CNNNews = {}
CNNNews.__index = CNNNews

--- Creates a CNNNews object
-- @return The object
function CNNNews:new()
	newObj = {
		name = "CNN",
		advertising = false,
		datePattern = "%a+, (%d+) (%a+) (%d+) (%d+):(%d+):(%d+) (%a+)",
    datePatternTravel = "%a+, (%d+) (%a+) (%d+) (%d+):(%d+):(%d+) %+(%d+)",
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
			['Space'] = 'http://rss.cnn.com/rss/edition_space.rss',
			['Entertainment'] = 'http://rss.cnn.com/rss/edition_entertainment.rss',
			['Sports'] = 'http://rss.cnn.com/rss/edition_sport.rss',
			['football'] = 'http://rss.cnn.com/rss/edition_football.rss',
			['golf'] = 'http://rss.cnn.com/rss/edition_golf.rss',
			['motor'] = 'http://rss.cnn.com/rss/edition_motorsport.rss',
			['tennis'] = 'http://rss.cnn.com/rss/edition_tennis.rss',
      ['Travel'] = 'http://travel.cnn.com/rss.xml',
			['latest'] = 'http://rss.cnn.com/rss/cnn_latest.rss'
		}
	}
  self.__index = self
  return setmetatable(newObj, self)
end

--- Parse the article file
-- @return text The text
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

--- Get the article text by loading it from a link
-- @param link The link
-- @return calls the function parseArticleFile and returns the text
function CNNNews:getArticleText(link)
	download.downloadFile(link, articleFile)

	return self:parseArticleFile(articleFile)

end
