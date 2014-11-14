text = require "text"

detailNewsView = {}

-- Constructor of the detailNewsView class
function detailNewsView:new()
	newObj = {
		size = { w=gfx.screen:get_width(), h=gfx.screen:get_height() },
		surface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height()),
		currentPage = 1,
		newsFeed = nil
	}
	self.__index = self
	return setmetatable(newObj, self)
end

-- When the view is loaded for the first time. This will be executed once.
function detailNewsView:viewDidLoad()
	self.surface:clear({234,234,234,255})
	self:drawView()

end

-- When this view will dissapear and another view will be shown, this is executed.
function detailNewsView:viewDidEnd()
end

-- When the view has been loaded before and it is presented again.
function detailNewsView:drawView()
	self.newsSurfaces = text.createSplit(self.size.w-600, self.size.h-250, "lora_small", self.newsFeed.summary, 10, 10, self.size.w, self.size.h-300)
	self:printNews()
	gfx.screen:copyfrom(self.surface, nil, {x=0,y=0}, false)
	gfx.update()
end

function detailNewsView:printNews()
	local logoSurface = gfx.new_surface(self.size.w, self.size.h/6)
	logoSurface:clear({255,255,255,255})
	self.surface:copyfrom(logoSurface, nil, {x=0, y=0}, false)

	--Text position and size
	local textprint_x = 10
	local textprint_y = 0
	local textprint_w = self.size.w-10
	local textprint_h = 110

	--Title Surface 
	local titleSurface = gfx.new_surface(self.size.w, self:adaptSurface(self.newsFeed.title, "lato_medium"))
	titleSurface:clear({234,234,234,255})
	text.print(titleSurface, "lato_medium", self.newsFeed.title , textprint_x, textprint_y, textprint_w, titleSurface:get_height())
	self.surface:copyfrom(titleSurface, nil, {x= 0, y=logoSurface:get_height()}, false)
	local titleend = logoSurface:get_height() + titleSurface:get_height()

	--Date surface
	local dateSurface = gfx.new_surface(self.size.w, self:adaptSurface(self.newsFeed.date, "lato_small"))
	dateSurface:clear({234,234,234,255})
	text.print(dateSurface, "lato_small", self.newsFeed.date, textprint_x, textprint_y, textprint_w, textprint_h)
	self.surface:copyfrom(dateSurface, nil, {x= 0, y=titleend}, false)
	local dateend = titleend + dateSurface:get_height()
	local newsImgSurface = gfx.new_surface(self.size.w/2, self.size.h)
	newsImgSurface:clear({234,234,234,255})
	self.surface:copyfrom(self.newsSurfaces[self.currentPage], nil, {x= newsImgSurface:get_width(), y=dateend+10}, false)

	--News image surface
	self.surface:copyfrom(newsImgSurface, nil, {x=0, y=dateend}, false)
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
	elseif (font == "lato_small") then
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

-- When the view is deleted. (You may want to free the memory allowed to you surfaces)
function detailNewsView:freeView()
end


-- The detailNewsView has his own onKey function.
function detailNewsView:onKey(key, state)
	if state == 'up' then
		if key == 'left' then
			vc:presentView("newsFeed")
		elseif key == 'up' then
			if self.currentPage > 1 and #self.newsSurfaces > 1 then
				self.currentPage = self.currentPage - 1
				self:printNews()
			end
		elseif key == 'down' then
			if self.currentPage < #self.newsSurfaces then
				self.currentPage = self.currentPage + 1
				self:printNews()
			end
		end
	end
end

