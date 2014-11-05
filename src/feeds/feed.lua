
Feed = {}
Feed.__index = Feed

--methods on how to get the feeds may change so we need to have an representation of a feed
--so that if the method change and we translate the output to this class model, it can be used with other works

function Feed:new(title, summary, date, link, source)
	newObj = {
		title = title,
		summary = summary,
		date = date,
		link = link,
		source = source
	}
  self.__index = self
  return setmetatable(newObj, self)
end
