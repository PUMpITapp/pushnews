
text = require "text"
require "feeds.feed"
detailNewsView = {}

local feed = Feed:new("ABC DEFGH IJK LMNOP QRST UVWXY ZABC DEFG HIJK LMNOPQ RSTUV WXYZ", "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW", "Nov. 9, 2014 5:29 p.m. ET","http://online.wsj.com/articles/merkel-hails-fall-of-berlin-wall-as-proof-dreams-can-come-true-1415537034","blabla5", "blabla6")

-- Constructor of the detailNewsView class
function detailNewsView:new()
	newObj = {
		size = { w=gfx.screen:get_width(), h=gfx.screen:get_height() },
		surface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height())
	}
  self.__index = self
  return setmetatable(newObj, self)
end

-- When the view is loaded for the first time. This will be executed once.
function detailNewsView:viewDidLoad()
	self.surface:clear({63,81,181,255})
  self:drawView()
  
  self:printNews()
end

-- When this view will dissapear and another view will be shown, this is executed.
function detailNewsView:viewDidEnd()
end

-- When the view has been loaded before and it is presented again.
function detailNewsView:drawView()
	gfx.screen:copyfrom(self.surface, nil, {x=0,y=0}, false)
	gfx.update()
end

function detailNewsView:printNews()
local logoSurface = gfx.new_surface(self.size.w, self.size.h/6)
logoSurface:clear({255,255,255,255})
self.surface:copyfrom(logoSurface, nil, {x=0, y=0}, false)

local imageSurface = gfx.loadjpeg("images/aftonbladet.jpeg")

		self.surface:copyfrom(imageSurface, nil, {x=0, y=0}, false)


local titleSurface = gfx.new_surface(self.size.w, self.size.h/10)
titleSurface:clear({63,81,181,255})


--Text position and size
local textprint_x = 10
local textprint_y = 0
local textprint_w = self.size.w-10
local textprint_h = 0

--Title Surface 
	local titleSurface = gfx.new_surface(self.size.w, self:adaptSurface(feed.title, "lato_medium"))
titleSurface:clear({63,81,181,255})
text.print(titleSurface, "lato_medium", feed.title , textprint_x, textprint_y, textprint_w, textprint_h)
self.surface:copyfrom(titleSurface, nil, {x= 0, y=logoSurface:get_height()}, false)
local titleend = logoSurface:get_height() + titleSurface:get_height()

--Summary Surface
local summarySurface = gfx.new_surface(self.size.w, self:adaptSurface(feed.summary, "lato_small"))
summarySurface:clear({63,81,181,255})
text.print(summarySurface, "arial_regular_12", feed.summary, textprint_x, textprint_y, textprint_w, textprint_h)
self.surface:copyfrom(summarySurface, nil, {x= 0, y=titleend}, false)
local summaryend = titleend + summarySurface:get_height()

--Date surface
local dateSurface = gfx.new_surface(self.size.w, self:adaptSurface(feed.date, "lato_small"))
dateSurface:clear({63,81,181,255})
text.print(dateSurface, "arial_regular_12", feed.date, textprint_x, textprint_y, textprint_w, textprint_h)
self.surface:copyfrom(dateSurface, nil, {x= 0, y=summaryend}, false)

--News image surface
local newsimgsurface = gfx.loadjpeg("images/merkel.jpeg")
self.surface:copyfrom(newsimgsurface, nil, {x=0, y= summaryend + dateSurface:get_height()}, false)

print(string.len(feed.title))



self:drawView()



end

--Functions which adapts height of content-surface according to the size of the content
function detailNewsView:adaptSurface(stringlength, font)


	if (font == "lato_medium") then 
		local length = string.len(stringlength)
		local maxPerRow = 27
		if (length > maxPerRow) then

			local rows = math.ceil(length/maxPerRow)
			local height = rows * 43

			return height;

			elseif (length <= maxPerRow) then
			return 43

			end
		




else if (font == "lato_small") then

	local length = string.len(stringlength)
	local maxPerRow = 300
	if (length > maxPerRow) then

		local extension = length - maxPerRow
		local rows = math.ceil(extension/maxPerRow)
		local height = 21 + rows * 21

		return height

	elseif (length <= maxPerRow) then

		return 21
	end
end


end
end


-- When the view is deleted. (You may want to free the memory allowed to you surfaces)
function detailNewsView:freeView()
end


-- The detailNewsView has his own onKey function.
function detailNewsView:onKey(key, state)
	if state == 'up' then
  	if key == 'right' then
			vc:presentView("newsFeed")
  	end
	end
end

