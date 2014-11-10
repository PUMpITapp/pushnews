require "categoriesView"

describe("categoriesView:", function()

	it("Checks that the categoriesView contains the categories", function()

		local cv = categoriesView:new()
		local categories = {
												 { name = 'News', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },
												 { name = 'Health', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },
												 { name = 'Technology', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },
												 { name = 'Environment', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },
												 { name = 'Culture', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },
												 { name = 'Science', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },
												 { name = 'Ours', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },
												 { name = 'Ours', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' },
												 { name = 'Ours', selected = false, img_unselected = 'images/category_r.png', img_selected = 'images/category_r_selected.png' }
											 }

		assert.are.equals(cv:categories, categories)

	end)

	it("Checks that the category is selected", function()

		local cv = categoriesView:new()

		cv:selectCategory(1)
		cv:selectCategory(2)
		cv:selectCategory(3)
		cv:selectCategory(4)
		cv:selectCategory(5)
		cv:selectCategory(6)
		cv:selectCategory(7)
		cv:selectCategory(8)
		cv:selectCategory(9)

		assert.is_true(cv.categories[1].selected)
		assert.is_true(cv.categories[2].selected)
		assert.is_true(cv.categories[3].selected)
		assert.is_true(cv.categories[4].selected)
		assert.is_true(cv.categories[5].selected)
		assert.is_true(cv.categories[6].selected)
		assert.is_true(cv.categories[7].selected)
		assert.is_true(cv.categories[8].selected)
		assert.is_true(cv.categories[9].selected)

	end)

end)
