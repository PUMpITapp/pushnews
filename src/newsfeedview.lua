--Push news app
--
--Newsfeedview



local function main()
gfx = require "gfx"

gfx.screen:clear({255, 0, 0})

gfx.update()
dir = './'
png_menuButton = 'menuButton.png'

printMenuButton()
end



--Print mainbutton
function printMenuButton()

	local toScreen = nil

	toScreen = gfx.loadpng(dir..png_menu)
	gfx.screen:copyfrom(toScreen, nil, {x = 100, y=100})
	gfx.update()

end



