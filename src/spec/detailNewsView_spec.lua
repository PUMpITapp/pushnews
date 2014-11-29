require "main"

describe("detailNewsView:", function()
	it("Back to News Feeds", function()
    --vc:getView("categories"):onKey("green","up")
    --vc:getView("categories"):onKey("8","up")
  	--vc:getView("categories"):onKey("right","up")
  	--vc:getView("newsFeed"):onKey("1","up")
  	--vc:getView("detailNewsView"):onKey("left","up")
  	--local id,view = vc:getcurrentViewIdentifier()
  	--assert.are.equal(id,"newsFeed")
	end)
end)