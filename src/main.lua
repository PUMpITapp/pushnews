-- Every story needs a beginning, this is ours.

gfx = require "gfx"
text = require "text"
require "viewController"
require "categoriesView"
--require "newsFeedView"
require "detailNewsView"

-- Create a view controller for our app.
vc = viewController:new()

-- Let the view controller handle the onKey function
function onKey(key, state)
	vc:onKey(key, state)
end

-- onStart function is called at the beginning according to the Zenterio API
function onStart()
	-- Add some nice view
	vc:addView("categories", categoriesView:new())
	--vc:addView("newsFeed", NewsFeedView:new())
	vc:addView("detailNewsView", detailNewsView:new())
	-- Present the main view to the screen
	vc:presentView("detailNewsView")
end

-- Run the onStart() function. This has to be removed when running on the STB.
-- The LuaEngine on the STB will call this function by itself.
onStart()
