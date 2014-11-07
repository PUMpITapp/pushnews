
text = require "text"
feeds = require "feeds.feed"
detailNewsView = {}









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


local summarySurface = gfx.new_surface(self.size.w, self.size.h/10)
summarySurface:clear({63,160,181,255})

local summary_x = 10
local summary_y = 0
local summary_w = summarySurface:get_width()
local summary_h = 0

local header = "Facebok joins the fight against Ebola with News Feed donation drive"




if string.len(header) <= 146 then

	local summarySurface = gfx.new_surface(self.size.w, self.size.h/10)
summarySurface:clear({63,81,181,255})

text.print(summarySurface, "arial_regular_12", header , summary_x, summary_y, summary_w, summary_h)
self.surface:copyfrom(summarySurface, nil, {x= 0, y=logoSurface:get_height()}, false)
self:drawView()

print("less or equal to 146")

else if string.len(header) > 146 then
local length = string.len(header)
local length2 = length - 146
local rows = length2/49
local height = self.size.h/10 + rows * 30

local summarySurface = gfx.new_surface(self.size.w, height)
summarySurface:clear({63,160,181,255})

text.print(summarySurface, "arial_regular_12", header , summary_x, summary_y, summary_w, summary_h)
self.surface:copyfrom(summarySurface, nil, {x=0, y=0}, false)
self:drawView()

print ("bigger than 146")


end

end


print(string.len(header))
print (summarySurface:get_height())



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
