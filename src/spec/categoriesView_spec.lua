require "main"

local categoriesview = categoriesView:new()
categoriesview:viewDidLoad()

describe("Categories View:", function()
	it("Select Categories", function()
		local key = 1
		categoriesview:selectCategory(key)
		assert.is_true(categoriesview.categories[key].selected)
	end)

	it("Deselect Categories", function()
		local key = 1
		categoriesview:selectCategory(key)
		assert.is_false(categoriesview.categories[key].selected)
	end)
end)
