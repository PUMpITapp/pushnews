require "main"

describe("Categories View:", function()
	it("Select Categories", function()
		vc:getView("categories"):onKey("1","up")
		assert.is_true(vc:getView("categories").categories[1].selected)
	end)

	it("Deselect Categories", function()
		vc:getView("categories"):onKey("1","up")
    assert.is_false(vc:getView("categories").categories[1].selected)
	end)

  it("Select Source", function()
    vc:getView("categories"):onKey("green","up")
    assert.are.equal(vc:getView("categories").selectedSource,"SVD")

    vc:getView("categories"):onKey("red","up")
    assert.are.equal(vc:getView("categories").selectedSource,"CNN")
  end)

  it("Load News Feed View", function()
    vc:getView("categories"):onKey("1","up")
    vc:getView("categories"):onKey("right","up")
    local id,view = vc:getcurrentViewIdentifier()
    assert.are.equal(id,"newsFeed")
  end)
end)
