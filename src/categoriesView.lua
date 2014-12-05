-- categoriesView class
categoriesView = {}

--- Constructor of the categoriesView class
-- @return view A constructor table containing properties fpr the CategoriesView ----not too sure about this one... 
function categoriesView:new()
  newObj = {
    size = { w=gfx.screen:get_width(), h=gfx.screen:get_height() },
    backgroundColor = {232,232,232,255},
    availableSources = { "CNN", "CNN (Ads)" },
    selectedSource = "CNN"
  }
  self.__index = self
  return setmetatable(newObj, self)
end

--- When the view is loaded for the first time. This will be executed once.
function categoriesView:viewDidLoad()
  gfx.screen:clear(self.backgroundColor)
  self.categories = {
                     { name = 'Top stories', selected = false, img_unselected = 'images/topstories1.png', img_selected = 'images/topstories1_s.png' },
                     { name = 'World', selected = false, img_unselected = 'images/world2.png', img_selected = 'images/world2_s.png' },
                     { name = 'Europe', selected = false, img_unselected = 'images/europe3.png', img_selected = 'images/europe3_s.png' },
                     { name = 'Finance', selected = false, img_unselected = 'images/finance4.png', img_selected = 'images/finance4_s.png' },
                     { name = 'Entertainment', selected = false, img_unselected = 'images/entertainment5.png', img_selected = 'images/entertainment5_s.png' },
                     { name = 'Technology', selected = false, img_unselected = 'images/technology6.png', img_selected = 'images/technology6_s.png' },
                     { name = 'Travel', selected = false, img_unselected = 'images/travel7.png', img_selected = 'images/travel7_s.png' },
                     { name = 'Space', selected = false, img_unselected = 'images/space8.png', img_selected = 'images/space8_s.png' },
                     { name = 'Sports', selected = false, img_unselected = 'images/sports9.png', img_selected = 'images/sports9_s.png' }
                   }

  self.categories_w = self.size.w/1.3
  self.categories_h = self.size.h/1.3
  self.categories_x = self.size.w/2-self.categories_w/2
  self.categories_y = self.size.h/2-self.categories_h/2


  self.category_w = 800/3.2
  self.category_h = 500/3.2

  local logo = gfx.loadpng('images/push_news_logo.png')
  logo:premultiply()
  gfx.screen:copyfrom(logo, nil, {x=30, y=10, w=608*0.3, h=166*0.3})
  logo:destroy()

  logo = gfx.loadpng('images/pumpitapp.png')
  logo:premultiply()
  gfx.screen:copyfrom(logo, nil, {x=self.size.w-222, y=self.size.h-75, w=222, h=75}, true)
  logo:destroy()

  self:drawCategoriesSurface()
  self:drawView()

end

--- When this view will disappear and another view will be shown, this is executed.
function categoriesView:viewDidEnd()
end

--- When the view has been loaded before and it is presented again.
function categoriesView:drawView()
  local selectedCategories = self:getSelectedCategories()
  
  local button = gfx.loadpng('images/next.png')
  local buttonPos = { x=self.size.w-self.categories_x/2-button:get_width(), y=self.size.h/2-button:get_height()/2, w=32, h=68.75 }
  gfx.screen:clear(self.backgroundColor, buttonPos)

  if selectedCategories ~= nil and #selectedCategories > 0 then
    button:premultiply()
    gfx.screen:copyfrom(button, nil, buttonPos, true)
  end

  button:destroy()

  buttonPos = { x=self.size.w/2-64, y=self.size.h-76, w=39, h=29 }
  gfx.screen:clear(self.backgroundColor, {x=buttonPos.x, y=buttonPos.y, w=200, h=50})

  for key, val in pairs(self.availableSources) do
    -- Print colored button
    if self.selectedSource == val then
      button = gfx.loadpng('images/'.. val ..'_selected.png')
    else
      button = gfx.loadpng('images/'.. val ..'_unselected.png')
    end
    button:premultiply()
    gfx.screen:copyfrom(button, nil, buttonPos, true)
    button:destroy()
    -- Print source name
    local i, x = text.print(gfx.screen, "lora_regular_14_black", val, buttonPos.x+40, buttonPos.y+3, 200, nil)
    buttonPos.x = x + 10
  end

  gfx.update()
end

--- When the view is deleted. (You may want to free the memory allowed to you surfaces)
function categoriesView:freeView()
end

--- Print the available categories onto the categoriesView
function categoriesView:drawCategoriesSurface()
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

    self.categories[key].pos = {x=self.categories_x+cx, y=self.categories_y+cy, w=self.category_w, h=self.category_h}

    gfx.screen:copyfrom(categorySurface, nil, self.categories[key].pos, false)
    categorySurface:destroy()

    cx = cx + self.category_w + offset_x
  end

end

--- Make the selection of a category visible by changing the picture marking the category
-- @param key indicates which key on the remote control that is pressed
function categoriesView:selectCategory(key)
  local categorySurface = nil

  if self.categories[key].selected == false then
    self.categories[key].selected = true
    categorySurface = gfx.loadpng(self.categories[key].img_selected)
    gfx.screen:copyfrom(categorySurface, nil, self.categories[key].pos, false)
  else
    self.categories[key].selected = false
    categorySurface = gfx.loadpng(self.categories[key].img_unselected)
    gfx.screen:copyfrom(categorySurface, nil, self.categories[key].pos, false)

  end
  
  categorySurface:destroy()
  self:drawView()
end

--- Get the names of the selected categoies
-- @return selectedCategories Listing the categories selected by the user
function categoriesView:getSelectedCategories()
  local selectedCategories = {}

  for key, val in pairs(self.categories) do
    if val.selected == true then
      table.insert(selectedCategories, val.name)
    end
  end

  return selectedCategories
end

--- The categoriesView has his own onKey function.
-- @param key Indicates the selected key on the remote control
-- @param state Indicates if a button on the remote contol is pressed down or not        
function categoriesView:onKey(key, state)
  if state == 'up' then
    if key == 'right' then
      local selectedCategories = self:getSelectedCategories()

      if #selectedCategories >= 1 then
        local newsFeed = vc:getView("newsFeed")
        local detailnews = vc:getView("detailNewsView")
        detailnews.newsfeedpage = nil
        if self.selectedSource == "CNN" then
          newsFeed.feedProvider = CNNNews:new()
        else
          newsFeed.feedProvider = CNNNews:new()
          newsFeed.feedProvider.advertising = true
        end
        newsFeed.selectedCategories = selectedCategories
        vc:presentView("newsFeed")
      end
    elseif key == "red" then
      self.selectedSource = "CNN"
      self:drawView()
    elseif key == "green" then
      self.selectedSource = "CNN (Ads)"
      self:drawView()
    else
      key = tonumber(key)
      if key ~= nil and key >=1 and key <= 9 then
        self:selectCategory(key)
      end
    end
  end
end
