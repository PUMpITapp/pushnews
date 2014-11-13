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
	self.surface:clear({255,255,255,255})
	self.categories = {
										 { name = 'Top', selected = false, img_unselected = 'images/categories/topstories1.png', img_selected = 'images/categories/topstories1_s.png' },
										 { name = 'World', selected = false, img_unselected = 'images/categories/world2.png', img_selected = 'images/categories/world2_s.png' },
										 { name = 'Europe', selected = false, img_unselected = 'images/categories/europe3.png', img_selected = 'images/categories/europe3_s.png' },
										 { name = 'Finance', selected = false, img_unselected = 'images/categories/finance4.png', img_selected = 'images/categories/finance4_s.png' },
										 { name = 'Entertainment', selected = false, img_unselected = 'images/categories/entertainment5.png', img_selected = 'images/categories/entertainment5_s.png' },
										 { name = 'Technology', selected = false, img_unselected = 'images/categories/technology6.png', img_selected = 'images/categories/technology6_s.png' },
										 { name = 'Art', selected = false, img_unselected = 'images/categories/art7.png', img_selected = 'images/categories/art7_s.png' },
										 { name = 'Fashion', selected = false, img_unselected = 'images/categories/fashion8.png', img_selected = 'images/categories/fashion8_s.png' },
										 { name = 'Sports', selected = false, img_unselected = 'images/categories/sports9.png', img_selected = 'images/categories/sports9_s.png' }
									 }

	self.categories_w = self.size.w/1.3
	self.categories_h = self.size.h/1.3
	self.category_w = 800/3
	self.category_h = 500/3

	self:createCategoriesSurface()
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
function categoriesView:createCategoriesSurface()
	self.categoriesSurface = gfx.new_surface(self.categories_w,self.categories_h)
	self.categoriesSurface:clear({255,255,255,255})

	local nbCategoriesPerRow = math.floor(self.categories_w/self.category_w)
	local nbRow = math.ceil(#self.categories/nbCategoriesPerRow)
	local offset_x = (self.categories_w%self.category_w)/(nbCategoriesPerRow+1)
	local offset_y = (self.categories_h-(nbRow*self.category_h))/(nbRow+1)
	local cx = offset_x
	local cy = offset_y

	for key, val in pairs(self.categories) do
		local categorySurface = gfx.loadpng(val.img_unselected)

		if cx + self.category_w > self.categories_w then
			cx = offset_x
			cy = cy + self.category_h + offset_y
		end

		self.categories[key].x = cx
		self.categories[key].y = cy
		self.categoriesSurface:copyfrom(categorySurface, nil, {x=cx, y=cy, w=self.category_w, h=self.category_h}, false)
		categorySurface:destroy()

		cx = cx + self.category_w + offset_x
	end

end

function categoriesView:drawCategoriesSurface()
	local categoriesSurface_x = self.size.w/2-self.categories_w/2
	local categoriesSurface_y = self.size.h/2-self.categories_h/2
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

	self.categoriesSurface:copyfrom(categorySurface, nil, {x=self.categories[key].x, y=self.categories[key].y, w=self.category_w, h=self.category_h}, false)
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
			local selectedCategories = self:getSelectedCategories()

			if #selectedCategories >= 1 then
				local newsFeed = vc:getView("newsFeed")
				newsFeed.view.selectedCategories = selectedCategories
				vc:presentView("newsFeed")
			end
		else
			key = tonumber(key)
			if key ~= nil and key >=1 and key <= 9 then
				self:selectCategory(key)
			end
  	end
	end
end
