require 'feeds.categoriegetter'

describe("CategorieGetter:", function()
  it("test the CategorieGetter initializer", function()
  	local categoriegetter = CategorieGetter:new()

  	local i = 0

  	for name, cat in pairs(categoriegetter.categories) do
  		assert.is_not_same(nil, cat.image)
  		assert.is_true(#cat.providers > 0)
  		i = i + 1
  	end

  	assert.is_true(i > 0)

  end)

end)