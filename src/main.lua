-- Every story needs a beginning, this is ours.
local runningOnBox = false

--- Checks if the file was called from a test file.
--@return #boolean If the file is being tested or not 
function checkTestMode()
  runFile = debug.getinfo(2, "S").source:sub(2,3)
  if (runFile ~= './' ) then
    underGoingTest = false
  elseif (runFile == './') then
    underGoingTest = true
  end
  return underGoingTest
end

--- Deciding which gfx that are being used, the stub or the real
-- @param #boolean underGoingTest If the file is called in the test file
-- @return #string The real gfx or the stub gfx
function chooseGfx(underGoingTest)
  if not underGoingTest then
    tempGfx = require "gfx"
  elseif underGoingTest then
    tempGfx = require "gfx_stub"
  end
  return tempGfx
end

if runningOnBox == true then
  package.path = package.path .. ';' .. sys.root_path() .. '?.lua'
  package.path = package.path .. ';' .. sys.root_path() .. 'images/?.png'
  package.path = package.path .. ';' .. sys.root_path() .. 'feeds/?.lua'
else
  gfx = chooseGfx(checkTestMode())
  sys = {}
  sys.root_path = function () return '' end
end

require('utf8')
require "viewController"
require "categoriesView"
require "detailNewsView"
require "newsFeedView"
require "feeds.categoriegetter"
require "feeds.feedgetter"
require "feeds.cnnNews"
require "feeds.svdNews"
text = require "text"
http = require("socket.http")
io = require("io")
ltn12 = require("ltn12")

-- Create a view controller for our app.
vc = viewController:new()

-- Let the view controller handle the onKey function
--@parameter key #string keyboard input
--@parameter state #string state of the key, down = pressed, up = released
function onKey(key, state)
  vc:onKey(key, state)
end

-- onStart function is called at the beginning according to the Zenterio API
function onStart()
  -- Add some nice view
  vc:addView("categories", categoriesView:new())
  vc:addView("newsFeed", NewsFeedView:new())
  vc:addView("detailNewsView", detailNewsView:new())
  -- Present the main view to the screen
  vc:presentView("categories")
end

-- Run the onStart() function. This has to be removed when running on the STB.
-- The LuaEngine on the STB will call this function by itself.
onStart()
