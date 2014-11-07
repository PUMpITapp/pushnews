-- categoriesView class

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
	self.categories = {
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

	local categories_width = self.size.w/1.5
	local categories_height = self.size.h/1.5
	self:createCategoriesSurface(categories_width, categories_height)
	self:drawCategoriesSurface()
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
function categoriesView:createCategoriesSurface(w, h)
	self.categoriesSurface = gfx.new_surface(w,h)
	self.categoriesSurface:clear({63,160,181,255})

	local cw = 200
	local ch = 120
	local nbCategories = math.floor(w/cw)
	local offset = (w%cw)/(nbCategories+1)
	local cx = offset
	local cy = offset

	for key, val in pairs(self.categories) do
		local categorySurface = gfx.loadpng(val.img_unselected)
		if cx+cw > w then
			cx = offset
			cy = cy + ch + offset
		end
		self.categories[key].x = cx
		self.categories[key].y = cy
		self.categoriesSurface:copyfrom(categorySurface, nil, {x=cx, y=cy, w=cw, h=ch}, false)
		cx = cx + cw + offset
		categorySurface:destroy()
	end

end

function categoriesView:drawCategoriesSurface()
	local categoriesSurface_x = self.size.w/2-self.categoriesSurface:get_width()/2
	local categoriesSurface_y = self.size.h/2-self.categoriesSurface:get_height()/2
	self.surface:copyfrom(self.categoriesSurface, nil, {x=categoriesSurface_x, y=categoriesSurface_y}, false)
	self:drawView()
end

function categoriesView:selectCategory(key)
	local categorySurface = nil

	if self.categories[key].selected == false then
		self.categories[key].selected = true
		categorySurface = gfx.loadpng(self.categories[key].img_selected)
	else
		self.categories[key].selected = false
		categorySurface = gfx.loadpng(self.categories[key].img_unselected)
	end

	self.categoriesSurface:copyfrom(categorySurface, nil, {x=self.categories[key].x, y=self.categories[key].y, w=200, h=120}, false)
	categorySurface:destroy()
	self:drawCategoriesSurface()
end

function categoriesView:getSelectedCategories()
	local selectedCategories = {}

	for key, val in pairs(self.categories) do
		if val.selected == true then
			table.insert(selectedCategories, val.name)
		end
	end

	return selectedCategories
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
