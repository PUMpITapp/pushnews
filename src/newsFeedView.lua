-- Push news app
-- newsfeedview class
require "feeds.categoriegetter"
require "feeds.feedgetter"
require "feeds.cnnNews"

local news_index = 1
local each_section = 6
local key_counter = 1
local num_of_col = 3
local newsFeedTmpFile = "feeds/test.xml"
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
	self.news = self:fetchNews(self.selectedCategories)

	self.headerSurface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height()/8)
	self.bottomSurface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height()/8)
	self.newsSurface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height()-self.headerSurface:get_height()-self.bottomSurface:get_height())

	self.headerSurface:clear({63,81,181,255})
	self.bottomSurface:clear({63,81,181,255})
	self.newsSurface:clear({63,81,181,255})

	local menuButton = gfx.loadpng('images/push_news_logo.png')
	local menuButtonScalingFactor = self.headerSurface:get_height()/menuButton:get_height()
	self.headerSurface:copyfrom(menuButton, nil, { x = 30, y = 0, w=menuButton:get_width()*menuButtonScalingFactor, h=menuButton:get_height()*menuButtonScalingFactor })
	menuButton:destroy()

	self:printNews(num_of_col)

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
	self.surface:copyfrom(self.headerSurface, nil, { x=0, y=0 }, false)
	self.surface:copyfrom(self.newsSurface, nil, { x=0, y=self.headerSurface:get_height() }, false)
	self.surface:copyfrom(self.bottomSurface, nil, { x=0, y=self.headerSurface:get_height()+self.newsSurface:get_height() }, false)

	gfx.screen:copyfrom(self.surface, nil, { x=0, y=0 }, false)
	gfx.update()
end

function NewsFeedView:printNews(s_size)
	local section_size = s_size
	local section_width = self.newsSurface:get_width()/section_size
	local frame_width = (section_width*50)/100
	local frame_height = (section_width*50)/100
	local move_frame_y = 35
	local move_frame_x 
	local news_summary = gfx.new_surface(frame_width, frame_height)
	local news_pic = nil

	self.newsSurface:clear({63,81,181,255})

	local end_point
	key_counter = 1

	if (each_section+news_index) > #self.news then
		end_point = #self.news
	else
		end_point = each_section+news_index-1
	end

	for i=news_index, end_point do
		news_summary:clear({197,202,233,255})
		move_frame_x = (section_width*25/100)+((i-1)%section_size)*section_width
		text.print(news_summary, "arial_regular_12", tostring(key_counter), 1, 1, nil, nil, 1)

		if self.news[i].image == nil then
			news_pic = nil
			text.print(news_summary, "arial_regular_12", self.news[i].date, 15, 10, nil, nil, 1)
			text.print(news_summary, "arial_regular_12", self.news[i].title, 15, 60, nil, nil, 1)
		else
			news_pic = gfx.loadjpeg("images/news/" .. self.news[i].image)
			news_summary:copyfrom(news_pic, nil, { x=15, y=10, w=frame_width-30, h=frame_width-100 })
			text.print(news_summary, "arial_regular_12", self.news[i].title, 15, frame_width-90, nil, nil, 1)
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
				self:drawView()
			end
		elseif key == 'up' then
			if (news_index-each_section) < 0 then
				--do nothing
			else
				news_index = news_index-each_section
				self:printNews(num_of_col)
				self:drawView()
			end
		elseif key ~= nil then
			for i=1,key_counter-1 do
				if tostring(i) == key then
					print(self.news[i+(news_index-1)].title)
					--send to seledted news to DetailedNewsView and opnen it
				end
			end
		end
	end
end
