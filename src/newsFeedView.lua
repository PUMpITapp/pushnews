-- Push news app
-- newsfeedview class
require "feeds.categoriegetter"
require "feeds.feedgetter"
require "feeds.cnnNews"
local http = require("socket.http")
local io = require("io")
local ltn12 = require("ltn12")

local news_index = 1
local each_section = 6
local key_counter = 1
local num_of_col = 3
local newsFeedTmpFile = "feeds/test.xml"
local newsFeedTmpImg = "feeds/test.jpg"
-- Class definition
NewsFeedView = {}

--Class constructor
function NewsFeedView:new()
	newObj = {
		size = {w=gfx.screen:get_width(), h=gfx.screen:get_height()},
		surface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height()),
		categoryGetter = CategorieGetter:new(),
		feedGetter = FeedGetter:new(),
		feedProviders = { CNNNews:new() }
	}
	self.__index = self
	return setmetatable(newObj, self)
end

-- Loads the complete view
function NewsFeedView:viewDidLoad()
	self.headerSurface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height()/8)
	self.bottomSurface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height()/8)
	self.newsSurface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height()-self.headerSurface:get_height()-self.bottomSurface:get_height())

	self.headerSurface:clear({234,237,242,255})
	self.bottomSurface:clear({234,237,242,255})
	self.newsSurface:clear({234,237,242,255})

	local menuButton = gfx.loadpng('images/push_news_logo.png')
	local menuButtonScalingFactor = self.headerSurface:get_height()/menuButton:get_height()
	self.headerSurface:copyfrom(menuButton, nil, { x = 30, y = 0, w=menuButton:get_width()*menuButtonScalingFactor, h=menuButton:get_height()*menuButtonScalingFactor })
	menuButton:destroy()

	self:drawView()
end

function NewsFeedView:fetchNews(selectedCategories)
	local feeds = {}

	os.remove(newsFeedTmpFile)

-- If we need to have different preselected categories.
--	for k, selectedCategories in pairs(selectedCategories) do
--		local cat = self.categoryGetter.categories[selectedCategories]
--		if cat ~= nil then
--			for k1, provider in ipairs(cat.providers) do
--				local url = provider.categories[selectedCategories]
--				if url ~= nil then
--					self.feedGetter:downloadFeeds(url, newsFeedTmpFile)
--	  			local tmp = self.feedGetter:parseFeeds(newsFeedTmpFile)
--	  			for k3, news in pairs(tmp.entries) do
--	  				table.insert(feeds, news)
--	  			end
--				end
--			end
--		end
--	end

  for k1, selectedCategory in pairs(selectedCategories) do
  	for k2, provider in pairs(self.feedProviders) do
  		local url = provider.categories[selectedCategory]
  		if url ~= nil then
  			self.feedGetter:downloadFeeds(url, newsFeedTmpFile)
  			local tmp = self.feedGetter:parseFeeds(newsFeedTmpFile)
  			for k3, news in pairs(tmp.entries) do
  				table.insert(feeds, news)
  			end
  		end
  	end
  end

 	return feeds
end

-- Function to draw elements of the view
function NewsFeedView:drawView()
	self.news = self:fetchNews(self.selectedCategories)
	self:printNews(num_of_col)

	self.surface:copyfrom(self.headerSurface, nil, { x=0, y=0 }, false)
	self.surface:copyfrom(self.bottomSurface, nil, { x=0, y=self.headerSurface:get_height()+self.newsSurface:get_height() }, false)
	self:drawCurrentPage()
end

function NewsFeedView:drawCurrentPage()
	self.surface:copyfrom(self.newsSurface, nil, { x=0, y=self.headerSurface:get_height() }, false)
	gfx.screen:copyfrom(self.surface, nil, { x=0, y=0 }, false)
	gfx.update()
end

function NewsFeedView:printNews(s_size)
	local section_size = s_size
	local section_width = self.newsSurface:get_width()/section_size
	local frame_width = (section_width*70)/100
	local frame_height = (section_width*55)/100
	local move_frame_y = 35
	local move_frame_x 
	local news_summary = gfx.new_surface(frame_width, frame_height)
	local news_pic = nil
	local end_point
	key_counter = 1

	self.newsSurface:clear({234,237,242,255})

	if (each_section+news_index) > #self.news then
		end_point = #self.news
	else
		end_point = each_section+news_index-1
	end

	for i=news_index, end_point do
		news_summary:clear({255,255,255,255})
		news_summary:clear({50,58,69,255}, {x=0,y=0,w=news_summary:get_width(), h=35})
		news_summary:clear({159,167,180,255}, {x=0,y=news_summary:get_height()-60,w=news_summary:get_width(),h=60})

		move_frame_x = (section_width*15/100)+((i-1)%section_size)*section_width

		text.print(news_summary, "arial_regular_12", tostring(key_counter), 7, 5, nil, nil, 1)

		if self.news[i].images[1] == nil then
			news_pic = nil
			text.print(news_summary, "arial_regular_12", self.news[i].title, 15, news_summary:get_height()-60, nil, nil, 1)
			text.print(news_summary, "arial_regular_12", self.news[i].date:sub(1,16), 30, 5, nil, nil, 1)
		else			
			local url = self.news[i].images[1].url
			if url ~= nil then				
				local outputfile = io.open(newsFeedTmpImg, "w+")				
				http.request { 
			    url = url, 
			    sink = ltn12.sink.file(outputfile)
				}				
				--outputfile:close()
				local img = gfx.loadjpeg(newsFeedTmpImg)
				if img ~= nil then
					news_summary:copyfrom(img, nil, { x=0, y=35, w=news_summary:get_width(), h=news_summary:get_height()-35-60 }, false)
					img:destroy()
				end
			end			
			text.print(news_summary, "arial_regular_12", self.news[i].title, 15, news_summary:get_height()-60, news_summary:get_width()-15, nil, 1)
			text.print(news_summary, "arial_regular_12", self.news[i].date:sub(1,16), 30, 5, nil, nil, 1)
		end

		self.newsSurface:copyfrom(news_summary, nil, { x=move_frame_x, y=move_frame_y }, false)

		if (i-1)%section_size == section_size-1 then
			move_frame_y = move_frame_y+frame_height+30
		end
		key_counter = key_counter + 1
	end

	news_summary:destroy()

end

function NewsFeedView:onKey(key, state)
	if state == 'up' then
		if key == 'left' then
			vc:presentView('categories')
		elseif key == 'down' then
			if (news_index+each_section) > #self.news then
				--do nothing
			else
				news_index = news_index+each_section
				self:printNews(num_of_col)
				self:drawCurrentPage()
			end
		elseif key == 'up' then
			if (news_index-each_section) < 0 then
				--do nothing
			else
				news_index = news_index-each_section
				self:printNews(num_of_col)
				self:drawCurrentPage()
			end
		elseif key ~= nil then
			for i=1,key_counter-1 do
				if tostring(i) == key then
					local detailNewsView = vc:getView("detailNewsView")
					detailNewsView.view.newsFeed = self.news[i+(news_index-1)]
					vc:presentView("detailNewsView")
				end
			end
		end
	end
end
