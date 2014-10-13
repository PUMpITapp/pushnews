gfx = require "gfx"

local png_categories = { cat1 = 'images/news.png', 
												 cat2 = 'images/news.png',
												 cat3 = 'images/news.png',
												 cat4 = 'images/news.png',
												 cat5 = 'images/news.png',
												 cat6 = 'images/news.png',
												 cat7 = 'images/news.png'
											 }

MainMenuView = {}

function MainMenuView:new()
	newObj = {
		size = {w=gfx.screen:get_width(), h=gfx.screen:get_height()},
		surface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height())
	}
  self.__index = self
  return setmetatable(newObj, self)
end

function MainMenuView:viewDidLoad(newval)
	self.surface:clear({63,81,181,255})

	local categories_w = self.size.w/1.5
	local categories_h = self.size.h/1.5
	self:printCategories(self.size.w/2-categories_w/2, self.size.h/2-categories_h/2, categories_w, categories_h)
  self:drawView()
end

function MainMenuView:drawView()
	gfx.screen:copyfrom(self.surface, nil, {x=0,y=0}, false)
	gfx.update()
end

function MainMenuView:printCategories(x, y, w, h)
	local category_surface = gfx.new_surface(w,h)
	category_surface:clear({63,160,181,255})

	local categories_surface = {}
	
	for key, val in pairs(png_categories) do
		table.insert(categories_surface, gfx.loadpng(val))
	end

	for key, val in pairs(categories_surface) do
		cx = (key-1) * 128 + 20
		cy = 20
		category_surface:copyfrom(val, nil, {x=cx, y=cy}, false)
	end
	
	self.surface:copyfrom(category_surface, nil, {x=x, y=y}, false)
end

function MainMenuView:onKey()
  -- TODO
end

main = MainMenuView:new()
main:viewDidLoad()
