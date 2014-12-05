
Feed = {}
Feed.__index = Feed

--- Methods on how to get the feeds may change so we need to have an representation of a feed
-- so that if the method change and we translate the output to this class model, 
-- it can be used with other works
-- @param title The title of the news article
-- @param summary The summary of the news article
-- @param date The publish date of the news article
-- @param link The link of the news article
-- @param images The images of the news article
-- @return The news feed
function Feed:new(title, summary, date, link, images)
	newObj = {
		title = title,
		summary = summary,
		date = date,
		link = link,
		images = images,
    category = nil
	}
  self.__index = self
  return setmetatable(newObj, self)
end
