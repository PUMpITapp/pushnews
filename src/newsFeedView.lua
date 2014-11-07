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
function NewsFeedView:viewDidLoad()
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

	-- printing random news
	local news = {"Random News 1",
								"Random News 2",
								"Random News 3",
								"Random News 4",
								"Random News 5",
								"Random News 6"}

	local news_summary = gfx.new_surface(self.size.w-60,80)
	for i=1, 6 do
		news_summary:clear({226,220,254,255})
		text.print(news_summary,"arial_regular_12",1,1,1,nil,nil,1)
		text.print(news_summary,"arial_regular_12",news[i],10,10,nil,nil,1)
		gfx.screen:copyfrom(news_summary,nil,{x=30, y=(100 + (90*i))},false)
	end
	gfx.update()

	--printing Filtertab
	local filter_surface = gfx.new_surface(300,100)
	filter_surface:clear({68,160,200,255})
	gfx.update()
end

function NewsFeedView:onKey(key, state)
	if state == 'up' then
  	if key == 'left' then
  		vc:presentView("categories")
  	end
	end
end

function NewsFeedView:printNews()
-- TODO
end
