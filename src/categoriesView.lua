-- categoriesView class

categoriesView = {}

-- Constructor of the categoriesView class
function categoriesView:new()
  newObj = {
    size = { w=gfx.screen:get_width(), h=gfx.screen:get_height() }
  }
  self.__index = self
  return setmetatable(newObj, self)
end

-- When the view is loaded for the first time. This will be executed once.
function categoriesView:viewDidLoad()
  self.categories = {
                     { name = 'Top stories', selected = false, img_unselected = 'images/topstories1.png', img_selected = 'images/topstories1_s.png' },
                     { name = 'World', selected = false, img_unselected = 'images/world2.png', img_selected = 'images/world2_s.png' },
                     { name = 'Europe', selected = false, img_unselected = 'images/europe3.png', img_selected = 'images/europe3_s.png' },
                     { name = 'Finance', selected = false, img_unselected = 'images/finance4.png', img_selected = 'images/finance4_s.png' },
                     { name = 'Entertainment', selected = false, img_unselected = 'images/entertainment5.png', img_selected = 'images/entertainment5_s.png' },
                     { name = 'Technology', selected = false, img_unselected = 'images/technology6.png', img_selected = 'images/technology6_s.png' },
                     { name = 'Art', selected = false, img_unselected = 'images/art7.png', img_selected = 'images/art7_s.png' },
                     { name = 'Fashion', selected = false, img_unselected = 'images/fashion8.png', img_selected = 'images/fashion8_s.png' },
                     { name = 'Sports', selected = false, img_unselected = 'images/sports9.png', img_selected = 'images/sports9_s.png' }
                   }

  self.categories_w = self.size.w/1.3
  self.categories_h = self.size.h/1.3
  self.categories_x = self.size.w/2-self.categories_w/2
  self.categories_y = self.size.h/2-self.categories_h/2
  self.category_w = 800/3
  self.category_h = 500/3

  self:drawCategoriesSurface()
  self:drawView()
end

-- When this view will dissapear and another view will be shown, this is executed.
function categoriesView:viewDidEnd()
end

-- When the view has been loaded before and it is presented again.
function categoriesView:drawView()
  local selectedCategories = self:getSelectedCategories()
  
  if selectedCategories ~= nil and #selectedCategories > 0 then
    local button = gfx.loadpng('images/next.png')
    button:premultiply()
    gfx.screen:copyfrom(button, nil, { x=self.size.w-110, y=self.size.h/2-button:get_height()/2, w=32, h=68.75 }, true)
    button:destroy()
  end

  gfx.update()
end

-- When the view is deleted. (You may want to free the memory allowed to you surfaces)
function categoriesView:freeView()
end

-- Print the available categories onto the categoriesView
function categoriesView:drawCategoriesSurface()
  gfx.screen:clear({232,232,232,255})

  local nbCategoriesPerRow = math.floor(self.categories_w/self.category_w)
  local nbRow = math.ceil(#self.categories/nbCategoriesPerRow)

  local offset_x = (self.categories_w%self.category_w)/(nbCategoriesPerRow+1)
  local offset_y = (self.categories_h-(nbRow*self.category_h))/(nbRow+1)

  local cx = offset_x
  local cy = offset_y

  for key, val in pairs(self.categories) do
    local categorySurface = nil

    if val.selected == false then
      categorySurface = gfx.loadpng(val.img_unselected)
    else
      categorySurface = gfx.loadpng(val.img_selected)
    end

    if cx + self.category_w > self.categories_w then
      cx = offset_x
      cy = cy + self.category_h + offset_y
    end

    gfx.screen:copyfrom(categorySurface, nil, {x=self.categories_x+cx, y=self.categories_y+cy, w=self.category_w, h=self.category_h}, false)
    categorySurface:destroy()

    cx = cx + self.category_w + offset_x
  end

end

function categoriesView:selectCategory(key)
  local categorySurface = nil

  if self.categories[key].selected == false then
    self.categories[key].selected = true
  else
    self.categories[key].selected = false
  end

  self:drawCategoriesSurface()
  self:drawView()
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
        newsFeed.selectedCategories = selectedCategories
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
