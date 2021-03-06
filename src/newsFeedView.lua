-- Push news app
-- newsfeedview class
local newsFeedTmpFile = sys.root_path() .. "feed_rss_tmp.xml"
local newsFeedTmpImg = "feed_img_tmp.jpg"
-- Class definition
NewsFeedView = {}

--- Class constructor for the NewsFeedView
-- @return view A constructor table containing properties fpr the NewsFeedView ----not too sure about this one... 
function NewsFeedView:new()
  newObj = {
    size = { w=gfx.screen:get_width(), h=gfx.screen:get_height() },
    categoryGetter = CategorieGetter:new(),
    feedGetter = FeedGetter:new(),
    feedProvider = nil,
    newsPerPage = 6
  }
  self.__index = self
  return setmetatable(newObj, self)
end

--- Loads the complete NewsFeedView
function NewsFeedView:viewDidLoad()
  gfx.screen:clear({232,232,232})

  local loadingButton = gfx.loadpng('images/loading.png')
  loadingButton:premultiply()
  gfx.screen:copyfrom(loadingButton, nil, {x=self.size.w/2-100, y=self.size.h/2, w=32, h=32}, true)
  loadingButton:destroy()
  text.print(gfx.screen, "lora_regular_14_black", "Loading news feeds ..." , self.size.w/2-100+32+10, self.size.h/2+3, 400, nil)
  gfx.update()

  -- Set news container size and position
  self.newsContainer_w = self.size.w*0.68
  self.newsContainer_h = self.size.h*0.80
  if self.feedProvider.advertising == true then
    self.newsContainer_x = self.size.w/2-self.newsContainer_w/2
    self.newsContainer_y = self.size.h*0.06
  else
    self.newsContainer_x = self.size.w/2-self.newsContainer_w/2
    self.newsContainer_y = self.size.h*0.1
  end
  
  -- Set news size 
  self.news_w = 270
  self.news_h = 250

  -- Fetches the news on the internet
  self.news = self:fetchNews(self.selectedCategories)
  self:convertNewsDate()
  self:sortNewsByDate()

  -- Set newsIndex to 1 or where it left when the view is loaded
  local detailNewsView = vc:getView("detailNewsView")
  if detailNewsView.newsfeedpage == nil then
    self.newsIndex = 1
  elseif detailNewsView.newsfeedpage <= #self.news then
    self.newsIndex = detailNewsView.newsfeedpage
  elseif detailNewsView.newsfeedpage > #self.news then
    while detailNewsView.newsfeedpage > #self.news do
      detailNewsView.newsfeedpage = detailNewsView.newsfeedpage - newsPerPage
      self.newsIndex = detailNewsView.newsfeedpage
    end
  end
  
  -- Draw the view
  self:drawView()
end

-- Function to draw elements of the view
function NewsFeedView:drawView()
  -- Clear screen below logo and above the ads banner
  gfx.screen:clear({232,232,232})
  
  -- Print logo
  local logo = gfx.loadpng('images/push_news_logo.png')
  logo:premultiply()
  gfx.screen:copyfrom(logo, nil, {x=30, y=10, w=608*0.3, h=166*0.3})
  logo:destroy()

  -- Print the news to the screen
  self:printNews()

  -- Print previous button
  local button = gfx.loadpng('images/previous.png')
  button:premultiply()
  gfx.screen:copyfrom(button, nil, { x=self.newsContainer_x/2-button:get_width()/2, y=self.size.h/2-button:get_height()/2, w=32, h=68.75 }, true)
  button:destroy()

  -- Print up arrow if needed
  if self.newsIndex > self.newsPerPage then
    local button = gfx.loadpng('images/up.png')
    button:premultiply()
    gfx.screen:copyfrom(button, nil, { x=self.size.w-self.newsContainer_x/2-button:get_width()/2, y=self.size.h/3-button:get_height()/2, w=64, h=64 }, true)
    button:destroy()
  end
  
  -- Print down arrow if needed
  if self.newsIndex + self.newsPerPage <= #self.news then
    local button = gfx.loadpng('images/down.png')
    button:premultiply()
    gfx.screen:copyfrom(button, nil, { x=self.size.w-self.newsContainer_x/2-button:get_width()/2, y=self.size.h/3*2-button:get_height()/2, w=64, h=64 }, true)
    button:destroy()
  end

  -- Print advertising if needed
  if self.feedProvider.advertising == true then
    local banner = gfx.new_surface(self.newsContainer_w*0.75, 80)
    banner:clear({52, 152, 219})
    gfx.screen:copyfrom(banner, nil, {x=self.size.w/2-banner:get_width()/2, y=self.size.h-banner:get_height()-20}, true)
    banner:destroy()
  end
  
  -- Update the screen
  gfx.update()
end

--- Fetch news from the categories that were selected on the category view
-- @param selectedCategories selectedCategories Contains the categories that are selected by the user
-- @return feeds Contains the feeds that have been fetched
function NewsFeedView:fetchNews(selectedCategories)
  local feeds = {}

  os.remove(newsFeedTmpFile)

  for k1, selectedCategory in pairs(selectedCategories) do
    local url = self.feedProvider.categories[selectedCategory]
    if url ~= nil then
      self.feedGetter:downloadFeeds(url, newsFeedTmpFile)
      local tmp = self.feedGetter:parseFeeds(newsFeedTmpFile)
      for k3, news in pairs(tmp.entries) do
        news.category = selectedCategory
        table.insert(feeds, news)
      end
    end
  end

  return feeds
end

--- Convert the dates of the fetched news from the string format to a os.date format 
function NewsFeedView:convertNewsDate()
  local MON = {Jan=1, Feb=2, Mar=3, Apr=4, May=5, Jun=6, Jul=7, Aug=8, Sep=9, Oct=10, Nov=11, Dec=12}
  
  for i=1, #self.news do
    local day, month, year, hour, min, sec, tz
    if self.news[i].category == "Travel" then
      day, month, year, hour, min, sec, tz = self.news[i].date:match(self.feedProvider.datePatternTravel)
    else
      day, month, year, hour, min, sec, tz = self.news[i].date:match(self.feedProvider.datePattern)
    end
    local month = MON[month]
    self.news[i].date = os.time({tz=tz, day=day, month=month, year=year, hour=hour, min=min, sec=sec})
  end
end

--- Sort the news to be displayed on the NewsFeedView by date
function NewsFeedView:sortNewsByDate()
  -- should this inner function be commented in some way????
  local orderFunction = function (a, b) return a.date > b.date end
  table.sort(self.news, orderFunction)
end

--- Print the news, including the background and header colors and all the continent of the news on the serface
function NewsFeedView:printNews()
  local news_summary = gfx.new_surface(self.news_w, self.news_h)

  local nbNewsPerRow = math.floor(self.newsContainer_w/self.news_w)
  local nbRow = math.ceil(self.newsPerPage/nbNewsPerRow)

  local offset_x = (self.newsContainer_w%self.news_w)/(nbNewsPerRow+1)
  local offset_y = (self.newsContainer_h-(nbRow*self.news_h))/(nbRow+1)

  local cx = offset_x
  local cy = offset_y

  local title,tmp_string,count

  local newsIndexMax = self.newsIndex + self.newsPerPage - 1
  if newsIndexMax > #self.news then
    newsIndexMax = #self.news
  end

  for i=self.newsIndex, newsIndexMax do
    -- Fill in background color of news
    news_summary:clear({255,255,255,255})
    local noImage = false

    if cx + self.news_w > self.newsContainer_w then
      cx = offset_x
      cy = cy + self.news_h + offset_y
    end

    -- Print the image of the news to the screen
    if self.news[i].images[1] ~= nil then
      local url = self.news[i].images[1].url
      if url ~= nil then
        local outputfile = io.open(sys.root_path() .. newsFeedTmpImg, "w+")

        http.request {
          url = url,
          sink = ltn12.sink.file(outputfile)
        }

        local bimg = io.open(sys.root_path() .. newsFeedTmpImg, "rb")
        if string.byte(bimg:read(2)) == 255 then
          local img = gfx.loadjpeg(newsFeedTmpImg)
          if img ~= nil then
            news_summary:copyfrom(img, nil, { x=0, y=0, w=news_summary:get_width(), h=153 }, false)
            img:destroy()
          else
            noImage = true
          end
        else 
          noImage = true
        end
      else
        noImage = true
      end
    else
      noImage = true
    end

    if noImage == true then
      local img = gfx.loadpng(self.feedProvider.image)
      img:premultiply()
      news_summary:copyfrom(img, nil, { x=0, y=0, w=news_summary:get_width(), h=153 }, true)
      img:destroy()
    end

    -- Fill in header color of news
    news_summary:clear({255,255,255,255}, { x=0, y=0, w=25, h=25})

    -- Print news number, category, title and date
    text.print(news_summary, "lora_regular_14_black", tostring((self.newsPerPage+i-1)%self.newsPerPage+1), 7, 0, nil, nil)
    local cat_i, cat_x = text.print(news_summary, "lora_regular_12_red", string.upper(self.news[i].category), 15, 168, nil, nil)
    text.print(news_summary, "lora_regular_12_black", ' - ' .. os.date("%x", self.news[i].date), cat_x, 168, news_summary:get_width()-30, nil)

    -- '...' feature for long titles
    tmp_string = self.news[i].title
    count = 38
    if(string.len(tmp_string) >= count) then
      while  string.len(tmp_string) ~= count and string.sub(tmp_string,count,count) ~= ' ' do
        count = count + 1
      end
      title = string.sub(tmp_string,0,count).."..."
      text.print(news_summary, "lora_regular_14_black", title, 15, 195, news_summary:get_width()-30, nil)
    else
      text.print(news_summary, "lora_regular_14_black", tmp_string, 15, 195, news_summary:get_width()-30, nil)
    end

    -- Print the news to the screen
    gfx.screen:copyfrom(news_summary, nil, {x=self.newsContainer_x+cx, y=self.newsContainer_y+cy, w=self.news_w, h=self.news_h}, false)

    cx = cx + self.news_w + offset_x
  end

  news_summary:destroy()
end

--- Navigate with the arrows and numbers between the different views, scroll down in the newsFeedView and selecting one of the news
-- @param key Indicates the selected key on the remote control
-- @param state Indicates if a button on the remote contol is pressed down or not 
function NewsFeedView:onKey(key, state)
  if state == 'up' then
    if key == 'left' then
      vc:presentView('categories')
    elseif key == 'down' then
      if self.newsIndex + self.newsPerPage <= #self.news then
        self.newsIndex = self.newsIndex + self.newsPerPage
        self:drawView()
      end
    elseif key == 'up' then
      if self.newsIndex > self.newsPerPage then
        self.newsIndex = self.newsIndex - self.newsPerPage
        self:drawView()
      end
    else
      key = tonumber(key)
      if key ~= nil and key > 0 and key <= self.newsPerPage then
        local newsSelected = key + self.newsIndex - 1
        if self.news[newsSelected] ~= nil then
          local detailNewsView = vc:getView("detailNewsView")
          detailNewsView.newsfeedpage = self.newsIndex
          detailNewsView.feedProvider = self.feedProvider
          detailNewsView.newsFeed = self.news[newsSelected]
          vc:presentView("detailNewsView")
        end
      end
    end
  end
end
