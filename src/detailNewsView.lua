local lorem = ""

detailNewsView = {}

-- Constructor of the detailNewsView class
function detailNewsView:new()
  newObj = {
    size = { w=gfx.screen:get_width(), h=gfx.screen:get_height() },
    currentPage = 1,
    newsFeed = nil,
    pageIndexes = {},
    total_pages = nil,
    feedGetter = FeedGetter:new(),
    feedProvider = nil
  }
  self.__index = self
  return setmetatable(newObj, self)
end

-- When the view is loaded for the first time. This will be executed once.
function detailNewsView:viewDidLoad()  
  gfx.screen:clear({234,234,234,255})

  local loadingButton = gfx.loadpng('images/loading.png')
  loadingButton:premultiply()
  gfx.screen:copyfrom(loadingButton, nil, {x=self.size.w/2-100, y=self.size.h/2, w=32, h=32}, true)
  loadingButton:destroy()
  text.print(gfx.screen, "open_sans_regular_10", "Loading article ..." , self.size.w/2-100+32+10, self.size.h/2+3, 400, nil)
  gfx.update()

  self.currentPage = 1
  self.pageIndexes = {}

  lorem = self.feedProvider:getArticleText(self.newsFeed.link)

  self:drawView()
end

-- When this view will dissapear and another view will be shown, this is executed.
function detailNewsView:viewDidEnd()
end

-- When the view has been loaded before and it is presented again.
function detailNewsView:drawView()
  gfx.screen:clear({234,234,234,255})

  -- Creating split
  self:createSplit()

  --Set the total pages of the article
  self.total_pages = #self.pageIndexes

  --Printing the content for the current page
  self:printNews(self.currentPage)
 
  -- Update the interface
  gfx.update()
end


function detailNewsView:printNews(currentPage)
  --Set text position and size
  local textprint_x = 30
  local textprint_y = 100
  local textprint_w = gfx.screen:get_width()-10
  local textprint_h = 200

    -- Print logo
  local logo = gfx.loadpng('images/push_news_logo.png')
  logo:premultiply()
  gfx.screen:copyfrom(logo, nil, {x=30, y=10, w=608*0.3, h=166*0.3})
  logo:destroy()

  -- Set position for article text
  article_x = gfx.screen:get_width()/3+100
  article_w = gfx.screen:get_width()-700
  article_h = gfx.screen:get_height()-300
  printpage_y = gfx.screen:get_height()-50
  printpage_x = gfx.screen:get_width()/2

  --Print page number
  local printpage = "Page:" .. self.currentPage .. "/" .. self.total_pages

  --Print page content
  text.print(gfx.screen, "open_sans_regular_10", self.newsFeed.title , article_x, 50, textprint_w, textprint_h)
  text.print(gfx.screen, "open_sans_regular_8_black", os.date("%x  %X", self.newsFeed.date), textprint_x, textprint_y, textprint_w, 100)
  text.print(gfx.screen, "open_sans_regular_8_red", string.upper(self.newsFeed.category), textprint_x, 130, textprint_w, textprint_h)
  text.print(gfx.screen, "open_sans_regular_10", printpage , printpage_x, printpage_y, 200, 100)

  --Print news image
  local news_img = gfx.loadpng(self.feedProvider.image)
  news_img:premultiply()
  gfx.screen:copyfrom(news_img, nil, { x=130, y=230, w=300, h=337 }, true)
  news_img:destroy()

  --Print layout line
  local line = gfx.loadpng("images/black_line.png")
  line:premultiply()
  local widthimg = self.size.w/2 - line:get_width()
  gfx.screen:copyfrom(line, nil, { x=0, y=textprint_y+50, w=gfx.screen:get_width(), h=25 }, true)
  line:destroy()

  -- If it is the first page, full content should be printed.
  if currentPage == 1 then
    -- Print the news text
    text.print(gfx.screen, "open_sans_regular_10", lorem:sub(1, self.pageIndexes[self.currentPage]-1), article_x, 200, article_w, article_h)
  end

  -- Print previous button
  local prev_button = gfx.loadpng('images/previous.png')
  prev_button:premultiply()
  gfx.screen:copyfrom(prev_button, nil, { x=50, y=self.size.h/2-prev_button:get_height()/2, w=32, h=68.75 }, true)
  prev_button:destroy()

  -- If there are more pages than the currentPage, show the scroll down button.
  if self.currentPage < self.total_pages then
    local down_button = gfx.loadpng('images/down.png')
    down_button:premultiply()
    gfx.screen:copyfrom(down_button, nil, { x=self.size.w-150, y=self.size.h-200, w=64, h=64 }, true)
    down_button:destroy()
  end


  --If the currentPage is more than 1 show the scroll up button and print the article text for that page,
  if self.currentPage > 1 then
    local up_button = gfx.loadpng('images/up.png')
    up_button:premultiply()
    gfx.screen:copyfrom(up_button, nil, { x=self.size.w-150, y=textprint_y+150, w=64, h=64 }, true)
    up_button:destroy()
    
    -- Printing text from the last index in the last page to the index of the currentpage-1.    rarticle_x, 200, article_w, article_h)
    text.print(gfx.screen, "open_sans_regular_10", lorem:sub(self.pageIndexes[self.currentPage-1], self.pageIndexes[self.currentPage]-1), article_x, 200, article_w, article_h)
  end
end

--Seperates the text into several pages -> Adds every index to a table.
function detailNewsView:createSplit()
  -- Positions
  local textprint_x = 10
  local textprint_y = 100
  local textprint_w = gfx.screen:get_width()-10
  local textprint_h = 200

  article_x = gfx.screen:get_width()/3
  article_w = gfx.screen:get_width()-700
  article_h = gfx.screen:get_height()-300

  local stop = false
  local i = 1
  local page_counter = 0

  while stop == false do
    if i >= #lorem then
      stop = true
    else
      local ii, x = text.print(nil, "open_sans_regular_10", lorem:sub(i, #lorem), article_x, textprint_y, article_w , article_h)
      i = i + ii - 1
      table.insert(self.pageIndexes, i)
      page_counter = page_counter + 1
    end
  end
end

--Clears the screen and calls the printNews method to print text on the screen when currentPage > 1
function detailNewsView:reloadPage()
  gfx.screen:clear({234,234,234,255})
  self:printNews(self.currentPage)
  gfx.update()
end

-- When the view is deleted. (You may want to free the memory allowed to you surfaces)
function detailNewsView:freeView()
end

-- The detailNewsView has his own onKey function.
function detailNewsView:onKey(key, state)
  if state == 'up' then
    if key == 'left' then
      vc:presentView("newsFeed")
    elseif key == 'up' then
      if self.currentPage > 1 then
        self.currentPage = self.currentPage - 1
        self:reloadPage()        
      end
    elseif key == 'down' then
      if self.currentPage < self.total_pages then
        self.currentPage = self.currentPage + 1
        self:reloadPage()
      end
    end
  end
end

