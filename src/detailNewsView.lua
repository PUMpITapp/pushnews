text = require "text"


local lorem = " START 1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque sed, rutrum vulputate nunc. Nam cursus aliquam libero, at suscipit orci. Vivamus iaculis tincidunt varius. Curabitur eu odio turpis. Curabitur non nibh sed justo dictum condimentum. In in molestie miDonec molestie tellus et tortor lacinia, nec venenatis massa vehicula. Maecenas non imperdiet mauris. Donec iaculis est pellentesque vehicula porttitor. Ut interdum vehicula augue, quis auctor dui luctus ut. Duis posuere turpis nec eros scelerisque, sit amet accumsan massa convallis. Quisque tincidunt quis neque rhoncus ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper2. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum3 non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed risus tincidunt gravida.ullamcorper. Vestibulum non leo sed4 risus tincidunt gravidaRRR. 1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque1Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum a luctus neque. Praesent pulvinar enim id nisi lobortis, sit amet ullamcorper diam volutpat. Donec fermentum ipsum at magna ullamcorper maximus. Donec diam urna, dignissim non neque END "



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
    news = CNNNews:new()
  }
  self.__index = self
  return setmetatable(newObj, self)
end

-- When the view is loaded for the first time. This will be executed once.
function detailNewsView:viewDidLoad()
  
  self:clearTable(self.pageIndexes)

  gfx.screen:clear({234,234,234,255})
  print("article text:")
  local link = 'http://edition.cnn.com/2014/11/10/world/europe/russia-nato-new-cold-war/index.html'
  

  print(self.news:getArticleText(link))

  print(self.newsFeed.link)
 
  self:drawView()

end

-- When this view will dissapear and another view will be shown, this is executed.
function detailNewsView:viewDidEnd()
end

-- When the view has been loaded before and it is presented again.
function detailNewsView:drawView()

  -- Creating split
  self:createSplit()

  --Set the total pages of the article
  self.total_pages = self:countPages(self.pageIndexes)
  print("No. pages is: ")
  print(self.total_pages)
  -- Print the logo
  


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

  -- Set position for article text
  article_x = gfx.screen:get_width()/3+100
  article_w = gfx.screen:get_width()-300+100
  article_h = gfx.screen:get_height()-300
  printpage_y = gfx.screen:get_height()-50
  printpage_x = gfx.screen:get_width()/2


  

  local printpage = "Page:" .. self.currentPage .. "/" .. self.total_pages

  text.print(gfx.screen, "lato_medium", self.newsFeed.title , textprint_x, 0, textprint_w, textprint_h)

    
    text.print(gfx.screen, "lato_small", self.newsFeed.date, textprint_x, textprint_y, textprint_w, 100)

  text.print(gfx.screen, "lato_small", printpage , printpage_x, printpage_y, 200, 100)

  local news_img = gfx.loadpng("images/cnn.png")
    news_img:premultiply()
    gfx.screen:copyfrom(news_img, nil, { x=30, y=200, w=400, h=450 }, true)
    news_img:destroy()

    local line = gfx.loadpng("images/black_line.png")
    line:premultiply()
    local widthimg = self.size.w/2 - line:get_width()
    gfx.screen:copyfrom(line, nil, { x=0, y=textprint_y+50, w=gfx.screen:get_width(), h=25 }, true)
    line:destroy()

  -- If it is the first page, full content should be printed.
  if currentPage == 1 then



    -- Print the news text
    text.print(gfx.screen, "lato_small", lorem:sub(1, self.pageIndexes[self.currentPage]-1), article_x, 200, article_w, article_h)

  end


  --TODO: Printing image

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
      gfx.screen:copyfrom(up_button, nil, { x=self.size.w-150, y=self.size.h-600, w=64, h=64 }, true)
      up_button:destroy()
      

      -- Printing text from the last index in the last page to the index of the currentpage-1.    rarticle_x, 200, article_w, article_h)
      text.print(gfx.screen, "lato_small", lorem:sub(self.pageIndexes[self.currentPage-1], self.pageIndexes[self.currentPage]-1), article_x, 200, article_w, article_h)
        
      --text.print(gfx.screen, "lato_small", printpage , printpage_x, printpage_y, 100, 100)
    end
  end

function detailNewsView:clearTable(t)

 for k in pairs (t) do
    t [k] = nil
end

end
--Counts the number of entries in a table, returns the size(amounts of entries) of the table.
  function detailNewsView:countPages(table)

  local count = 0
  for _ in pairs(table) do count = count + 1 end
  return count

  end


--Seperates the text into several pages -> Adds every index to a table.
function detailNewsView:createSplit()

-- Positions
  local textprint_x = 10
  local textprint_y = 100
  local textprint_w = gfx.screen:get_width()-10
  local textprint_h = 200

 
 article_x = gfx.screen:get_width()/3
 article_w = gfx.screen:get_width()-300
 article_h = gfx.screen:get_height()-300


 
  local stop = false
  local i = 1
  local page_counter = 0

  while stop == false do
    if i >= #lorem then
      stop = true
    else
      
             
      i = i + text.print(nil, "lato_small", lorem:sub(i, #lorem), article_x, textprint_y, article_w , article_h) - 1
     
      table.insert(self.pageIndexes, i)

      page_counter = page_counter + 1
      
    end
  end

end

--Clears the screen and calls the printNews method to print text on the screen when currentPage > 1
function detailNewsView:reloadPage()

gfx.screen:clear({234,234,234,255})
gfx.update()

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
      
      elseif self.currentPage == self.total_pages then
        
      end

    elseif key == 'down' then
      if self.currentPage < self.total_pages then
        
        
        self.currentPage = self.currentPage + 1
        
        
        self:reloadPage()
      elseif self.currentPage == self.total_pages then

        print("no more pages")
      
      end
    end
  end
end

