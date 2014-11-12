require "main"

local categoriesview = categoriesView:new()
local newsfeedview = NewsFeedView:new()
local viewcontroller = viewController:new()

describe("viewController:", function()
	it("Add View", function()
		viewcontroller:addView("categories",categoriesview)
		viewcontroller:addView("newsFeed",newsfeedview)

		assert.are.equal(viewcontroller.views["categories"].view,categoriesview)
		assert.are.equal(viewcontroller.views["newsFeed"].view,newsfeedview)
	end)

	it("Remove View", function()
		viewcontroller:removeView("categories")
		--viewcontroller:removeView("newsFeed")
		assert.are.equal(viewcontroller.views["categories"],nil)
		--assert.are.equal(viewcontroller.views["newsFeed"],nil)
	end)

	it("Present View", function()
		viewcontroller:presentView("newsFeed")
		assert.is_true(viewcontroller.views["newsFeed"].loaded)
		end)
end)