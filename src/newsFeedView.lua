-- Push news app
-- newsfeedview class

local png_elements = { menubutton = 'images/sample.png' }
-- Class definition
NewsFeedView = {}

--Class constructor
function NewsFeedView:new()
	newObj = {
		size = {w=gfx.screen:get_width(), h=gfx.screen:get_height()},
		surface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height())
	}
	self.__index = self
	return setmetatable(newObj, self)
end

-- Loads the complete view
function NewsFeedView:viewDidLoad(newval)
	self.surface:clear({226,237,254,255})
	self:drawView()
end

-- Function to draw elements of the view
function NewsFeedView:drawView()
	gfx.screen:copyfrom(self.surface, nil, {x=0,y=0}, false)
	gfx.update()

	-- printing menuButton
	menu_png = png_elements.menubutton
	local toScreen = gfx.loadpng('images/small_menu.png')
	gfx.screen:copyfrom(toScreen, nil, {x = 30, y = 10})
	gfx.update()

	--printing Filtertab
	local filter_surface = gfx.new_surface(300,100)
	filter_surface:clear({68,160,200,255})
	gfx.update()
end

function NewsFeedView:onKey(key, state)
	if state == 'up' then
  	if key == '1' then
  		vc:presentView("main")
  	end
	end
end

function NewsFeedView:printNews()
-- TODO
end
