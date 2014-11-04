local categories = { 
										 { name = 'News', img = 'images/category_r.png' },  
										 { name = 'Health', img = 'images/category_r.png' },
										 { name = 'Technology', img = 'images/category_r.png' }, 
										 { name = 'Environment', img = 'images/category_r.png' },  
										 { name = 'Culture', img = 'images/category_r.png' },
										 { name = 'Science', img = 'images/category_r.png' },
										 { name = 'Ours', img = 'images/category_r.png' }
									 }

MainMenuView = {}

function MainMenuView:new()
	newObj = {
		size = { w=gfx.screen:get_width(), h=gfx.screen:get_height() },
		surface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height())
	}
  self.__index = self
  return setmetatable(newObj, self)
end

function MainMenuView:viewDidLoad()
	-- When the view is loaded for the first time. This will be executed once.
	self.surface:clear({63,81,181,255})
	local categories_w = self.size.w/1.5
	local categories_h = self.size.h/1.5
	self:printCategories(self.size.w/2-categories_w/2, self.size.h/2-categories_h/2, categories_w, categories_h)
  self:drawView()
end

function MainMenuView:viewDidEnd()
	-- When this view will dissapear and another view will be shown, this is executed.
end

function MainMenuView:drawView()
	-- When the view has been loaded before and it is presented again.
	gfx.screen:copyfrom(self.surface, nil, {x=0,y=0}, false)
	gfx.update()
end

function MainMenuView:freeView()
	-- When the view is deleted. (You may want to free the memory allowed to you surfaces)
end

function MainMenuView:printCategories(x, y, w, h)
	local categoriesSurface = gfx.new_surface(w,h)
	categoriesSurface:clear({63,160,181,255})

	local cw = 120
	local ch = 120
	local nbCategories = math.floor(w/cw)
	local offset = (w%cw)/(nbCategories+1)
	local cx = offset
	local cy = offset

	for key, val in pairs(categories) do
		local categorySurface = gfx.loadpng(val.img)
		if cx+cw > w then
			cx = offset
			cy = cy + ch + offset
		end
		categoriesSurface:copyfrom(categorySurface, nil, {x=cx, y=cy, w=cw, h=ch}, false)
		cx = cx + cw + offset
		categorySurface:destroy()
	end

	self.surface:copyfrom(categoriesSurface, nil, {x=x, y=y}, false)
end

function MainMenuView:onKey(key, state)
	if state == 'up' then
  	if key == '1' then
			vc:presentView("newsFeed")
  	end
	end
end
