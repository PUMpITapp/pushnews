local categories = { 
										 { name = 'News', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },  
										 { name = 'Health', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },
										 { name = 'Technology', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' }, 
										 { name = 'Environment', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },  
										 { name = 'Culture', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },
										 { name = 'Science', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },
										 { name = 'Ours', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },
										 { name = 'Ours', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },
										 { name = 'Ours', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' }
									 }

categoriesView = {}

-- Constructor of the categoriesView class
function categoriesView:new()
	newObj = {
		size = { w=gfx.screen:get_width(), h=gfx.screen:get_height() },
		surface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height())
	}
  self.__index = self
  return setmetatable(newObj, self)
end

-- When the view is loaded for the first time. This will be executed once.
function categoriesView:viewDidLoad()
	self.surface:clear({63,81,181,255})

	local categories_w = self.size.w/1.5
	local categories_h = self.size.h/1.5
	self.categoriesSurface_x = self.size.w/2-categories_w/2
	self.categoriesSurface_y = self.size.h/2-categories_h/2
	self:createCategories(categories_w, categories_h)
	self:drawCategories()
  self:drawView()
end

-- When this view will dissapear and another view will be shown, this is executed.
function categoriesView:viewDidEnd()
end

-- When the view has been loaded before and it is presented again.
function categoriesView:drawView()
	gfx.screen:copyfrom(self.surface, nil, {x=0,y=0}, false)
	gfx.update()
end

-- When the view is deleted. (You may want to free the memory allowed to you surfaces)
function categoriesView:freeView()
end

-- Print the available categories onto the categoriesView
function categoriesView:createCategories(w, h)
	self.categoriesSurface = gfx.new_surface(w,h)
	self.categoriesSurface:clear({63,160,181,255})

	local cw = 200
	local ch = 120
	local nbCategories = math.floor(w/cw)
	local offset = (w%cw)/(nbCategories+1)
	local cx = offset
	local cy = offset

	for key, val in pairs(categories) do
		local categorySurface = gfx.loadpng(val.img_unselected)
		if cx+cw > w then
			cx = offset
			cy = cy + ch + offset
		end
		categories[key].x = cx
		categories[key].y = cy
		self.categoriesSurface:copyfrom(categorySurface, nil, {x=cx, y=cy, w=cw, h=ch}, false)
		cx = cx + cw + offset
		categorySurface:destroy()
	end

end

function categoriesView:drawCategories()
	self.surface:copyfrom(self.categoriesSurface, nil, {x=self.categoriesSurface_x, y=self.categoriesSurface_y}, false)
	self:drawView()
end

function categoriesView:selectCategory(key)
	if categories[key].selected == false then
		categories[key].selected = true
		local categorySurface = gfx.loadpng(categories[key].img_selected)
		self.categoriesSurface:copyfrom(categorySurface, nil, {x=categories[key].x, y=categories[key].y, w=200, h=120}, false)
		self:drawCategories()
	else
		categories[key].selected = false
		local categorySurface = gfx.loadpng(categories[key].img_unselected)
		self.categoriesSurface:copyfrom(categorySurface, nil, {x=categories[key].x, y=categories[key].y, w=200, h=120}, false)
		self:drawCategories()
	end
end

-- The categoriesView has his own onKey function.
function categoriesView:onKey(key, state)
	if state == 'up' then
  	if key == 'right' then
			vc:presentView("newsFeed")
		else
			key = tonumber(key)
			if key >=1 and key <= 9 then
				self:selectCategory(key)
			end
  	end
	end
end
