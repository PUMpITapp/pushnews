require 'feeds.cnnNews'

CategorieGetter = {}
CategorieGetter.__index = CategorieGetter

registeredCategories = {
	europe = 'link...'
}

noCatLink = 'noCatLink'

--- Creates new CategorieGetter
-- @return new CategorieGetter
function CategorieGetter:new()
	local providers = { CNNNews:new() }
	local categories = {}

	for i, provider in ipairs (providers) do

		for categorie, link in pairs (provider.categories) do

			--if this category does not exist yet we have to initialize its content
			if categories[categorie] == nil then

				categories[categorie] = {}
				
				--initialize the provider array for this category
				categories[categorie].providers = {}
				
				-- if this category is a registered category then we can give it a special image
				if registeredCategories[categorie] == nil then
					categories[categorie].image = noCatLink
				else
					categories[categorie].image = registeredCategories[categorie]
				end
			end

			table.insert(categories[categorie].providers, provider)
		end
	end

	newObj = {
		providers = providers,
		categories = categories
	}

  self.__index = self
  return setmetatable(newObj, self)
end