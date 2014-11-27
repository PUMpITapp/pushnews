local SLAXML = require 'slaxdom'

require 'feeds.htmlLib'
require 'feeds.download'

local articleFile = "feeds/article.html"

SVDNews = {}
SVDNews.__index = SVDNews

function SVDNews:getParagraphs(elements)
	local t = {}

	if elements == nil then
		return nil
	end

	for i, e in pairs(elements) do
		if e._tag == 'p' and e._attr.class == nil then
			table.insert(t, e)
		elseif e ~= nil and type(e) == 'table' then

			local other = SVDNews:getParagraphs(e)

			for k, o in ipairs(other) do
				table.insert (t, o)
			end
		end
	end

	return t
end

function SVDNews:new()
	newObj = {
		name = "SVD",
		advertising = true,
		datePattern = "%a+, (%d+) (%a+) (%d+) (%d+):(%d+):(%d+) %+(%d+)",
		categories = {
			['Top stories'] = 'http://www.svd.se/?service=rss',
			['World'] = 'http://www.svd.se/nyheter/utrikes/?service=rss',
			['Europe'] = 'http://www.svd.se/nyheter/inrikes/?service=rss',
			['Finance'] = 'http://www.svd.se/naringsliv/?service=rss',
			['Technology'] = 'http://www.svd.se/naringsliv/branscher/teknik-och-telekom/?service=rss',
			['Entertainment'] = 'http://www.svd.se/kultur/?service=rss',
			['Sports'] = 'http://www.svd.se/sport/?service=rss',
			['Art'] = 'http://www.svd.se/kultur/konst/?service=rss',
			['Fashion'] =  'http://blog.svd.se/modebloggen/feed/'
		}
	}
  self.__index = self
  return setmetatable(newObj, self)
end

function SVDNews:parseArticleFile(articleFile)
	local htmlstr = io.open(articleFile):read('*all')
	
	local html = require 'html'

  local root = html.parsestr(htmlstr)
	
	local block = HTML.findClass(root, 'articletext')[1]
	if block == nil then
		block = HTML.findClass(root, 'entry')[1]
	end

	local paragraphs = self:getParagraphs(block)

	local text = HTML.getText (paragraphs)

	return text

end

function SVDNews:getArticleText(link)
	download.downloadFile(link, articleFile)

	local text = self:parseArticleFile(articleFile)

	if text == nil then
		text = ''
	end

	return text

end
