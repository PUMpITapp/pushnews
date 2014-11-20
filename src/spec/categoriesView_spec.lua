require "main"

local vc = viewController:new()
local categoriesview = categoriesView:new()
local newsfeedview = NewsFeedView:new()

vc:addView("categories", categoriesview)
vc:addView("newsFeed", newsfeedview)
vc:presentView("categories")


describe("Categories View:", function()
	it("Select Categories", function()
		categoriesview:onKey("1","up")
		assert.is_true(categoriesview.categories[1].selected)
	end)

	it("Deselect Categories", function()
		categoriesview:onKey("1","up")
		assert.is_false(categoriesview.categories[1].selected)
	end)
end)
