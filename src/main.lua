gfx = require "gfx"
require "MainMenuView"

function onKey(key, state)
	print('test')
end

main = MainMenuView:new()
main:loadView()
