require "main"

local categoriesview = categoriesView:new()
local viewcontroller = viewController:new()
local identifier = "categories"

describe("viewController:", function()
	it("Add View", function()
		viewcontroller:addView(identifier,categoriesview)
		assert.are.equal(viewcontroller.views[identifier],categoriesview)
	end)

  it("Get View", function()
    local view = viewcontroller:getView(identifier)
    assert.are.equal(categoriesview,view)
  end)

	it("Remove View", function()
		viewcontroller:removeView(identifier)
		assert.are.equal(viewcontroller.views[identifier],nil)
	end)
end)