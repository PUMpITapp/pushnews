-- Push news app
-- newsfeedview class

gfx = require "gfx"

local png_elements = { menubutton = 'images/sample.png'

}
-- Class definition
NewsFeedView = {}

--Class constructor
function NewsFeedView:new()

	newObj = {
		size = {w=gfx.screen:get_width(), h=gfx.screen:get_height()},
		surface = gfx.new_surface(gfx.screen:get_width(), gfx.screen:get_height())
	}
	self._index = self

	return setmetatable(newObj, self)
	end

-- Loads the complete view
function NewsFeedView:viewDidLoad(newval)
self.surface:clear({226,237,254,255})
self:drawView()

end

-- Function to draw elements of the view
function NewsFeedView:drawView()
gfx.screen:copyfrom(self.surface, nil, {x=0,y=0}, false)
gfx.update()
end

function NewsFeedView:printNews()
-- TODO
end



main = NewsFeedView:new()
main:viewDidLoad()

