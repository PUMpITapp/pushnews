-- Push news app
-- newsfeedview class
require "feeds.feed"

local which_section = 1
local number_section = 6
-- Class definition
NewsFeedView = {}

--Class constructor
function NewsFeedView:new()
	newObj = {
		size = {w=gfx.screen:get_width(), h=gfx.screen:get_height()},
		surface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height())
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

	self.headerSurface:clear({255, 237, 254, 255})
	self.bottomSurface:clear({255, 237, 254, 255})
	self.newsSurface:clear({226, 237, 254, 255})

	local menuButton = gfx.loadpng('images/small_menu.png')
	self.headerSurface:copyfrom(menuButton, nil, { x = 30, y = 10 })
	menuButton:destroy()

	self:printNews(3, self:divideNewsToSections())

	self:drawView()
end

function NewsFeedView:fetchNews(selectedCategories)
	local news = {}

	table.insert(news, Feed:new("Swansea City 2-1 Arsenal",
															"Swansea fight back from a goal down to beat Arsenal and move up to fifth in the Premier League table.",
															"01/11/2014","Link 1","Source 1",
															"sport1.jpg"))
	table.insert(news, Feed:new("China's economic risks 'not scary'",
															"President Xi Jinping plays down the risks facing China's economy, at a meeting of business leaders ahead of the Apec summit.",
															"07/11/2014","Link 2","Source 1",
															"business1.jpg"))
	table.insert(news, Feed:new("Title 3", "Summary 3", "03/11/2014", "Link 3", "Source 1", nil))
	table.insert(news, Feed:new("Title 4", "Summary 4", "01/10/2014", "Link 4", "Source 1", nil))
	table.insert(news, Feed:new("Title 5", "Summary 5", "03/11/2014", "Link 5", "Source 1", nil))
	table.insert(news, Feed:new("Title 6", "Summary 6", "04/09/2014", "Link 6", "Source 1", nil))
	table.insert(news, Feed:new("Title 7", "Summary 7", "04/10/2014", "Link 7", "Source 1", nil))
	table.insert(news, Feed:new("Title 8", "Summary 8", "12/10/2014", "Link 8", "Source 1", nil))

 	return news
end

-- Function to draw elements of the view
function NewsFeedView:drawView()
	self.surface:copyfrom(self.headerSurface, nil, { x=0, y=0 }, false)
	self.surface:copyfrom(self.newsSurface, nil, { x=0, y=self.headerSurface:get_height() }, false)
	self.surface:copyfrom(self.bottomSurface, nil, { x=0, y=self.headerSurface:get_height()+self.newsSurface:get_height() }, false)

	gfx.screen:copyfrom(self.surface, nil, { x=0, y=0 }, false)
	gfx.update()
end

function NewsFeedView:printNews(s_size, news)
	local section_size = s_size
	local section_width = self.size.w/section_size
	local frame_width = (section_width*80)/100
	local frame_hight = (section_width*85)/100
	local move_frame_y = 100
	local move_frame_x = (section_width*10/100)
	local news_summary = gfx.new_surface(frame_width, frame_hight)
	local news_pic = nil

	self.newsSurface:clear({226,237,254,255})

	for i=0, #news-1 do
		news_summary:clear({226,220,254,255})
		move_frame_x = (section_width*10/100)+(i%section_size)*section_width
		text.print(news_summary, "arial_regular_12", tostring(i+1), 1, 1, nil, nil, 1)

		if news[i+1].image == nil then
			news_pic = nil
			text.print(news_summary, "arial_regular_12", news[i+1].title, 15, 10, nil, nil, 1)
		else
			news_pic = gfx.loadjpeg("images/news/" .. news[i+1].image)
			news_summary:copyfrom(news_pic, nil, { x=15, y=10, w=frame_width-30, h=frame_width-100 })
			text.print(news_summary, "arial_regular_12", news[i+1].title, 15, frame_width-90, nil, nil, 1)
		end

		--text.print(news_summary,"arial_regular_12",news[i+1].summary,20,30,nil,1)
		self.newsSurface:copyfrom(news_summary, nil, { x=move_frame_x, y=move_frame_y }, false)

		if i%section_size == section_size-1 then
			move_frame_y = move_frame_y+frame_hight+30
		end
	end

	news_summary:destroy()

end

function NewsFeedView:divideNewsToSections()
	local section = {}
	local end_point

	if (number_section+which_section) > #self.news then
		end_point = #self.news
	else
		end_point = number_section+which_section-1
	end

	for i=which_section, end_point do
		table.insert(section,self.news[i])
	end

	return section
end

function NewsFeedView:onKey(key, state)
	if state == 'up' then
		if key == 'Down' then
			if (which_section+number_section) > #self.news then
				--do nothing
			else
				which_section = which_section+number_section
				self:printNews(3, self:divideNewsToSections())
				self:drawView()
			end
		elseif key == 'Up' then
			if (which_section-number_section) < 0 then
				--do nothing
			else
				which_section = which_section-number_section
				self:printNews(3, self:divideNewsToSections())
				self:drawView()
			end
		end
	end

	if state == 'up' then
		for i=1 , #self.news do
			if tostring(i) == key then
				print(self.news[i+(which_section-1)].title)
				--sned to seledted news to DetailedNewsView and opnen it
			end
  	end
	end
end

