require "main"


describe("detailNewsView:", function()

it("Press left key to return to newsfeedview", function()

	local detailview = detailNewsView:new()
	local newsfeedview = NewsFeedView:new()
	local viewController = viewController:new()
	viewController:addView("detailNewsView",detailview)
	viewController:addView("newsFeed",newsfeedview)
	viewController:presentView("detailNewsView")
	--detailview:onKey("left", "up")

	local view = viewController:getcurrentViewIdentifier()
	print(view)
	--assert.is_same(view,newsfeedview)
	
	end)
end)

