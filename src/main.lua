-- Every story needs a beginning, this is ours.
local runningOnBox = true

--- Checks if the file was called from a test file.
-- Returs true if it was,
--   - which would mean that the file is being tested.
-- Returns false if it was not,
--   - which wold mean that the file was being used.
function checkTestMode()
  runFile = debug.getinfo(2, "S").source:sub(2,3)
  if (runFile ~= './' ) then
    underGoingTest = false
  elseif (runFile == './') then
    underGoingTest = true
  end
  return underGoingTest
end

--- Chooses either the actual or he dummy gfx.
-- Returns dummy gfx if the file is being tested.
-- Rerunes actual gfx if the file is being run.
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

text = require "text"
require "viewController"
require "categoriesView"
require "detailNewsView"
require "newsFeedView"
require "feeds.categoriegetter"
require "feeds.feedgetter"
require "feeds.cnnNews"
http = require("socket.http")
io = require("io")
ltn12 = require("ltn12")

-- Create a view controller for our app.
vc = viewController:new()

-- Let the view controller handle the onKey function
function onKey(key, state)
  vc:onKey(key, state)
end

-- onStart function is called at the beginning according to the Zenterio API
function onStart()
  -- Add some nice view
  vc:addView("categories", categoriesView:new())
  vc:addView("newsFeed", NewsFeedView:new())
  --vc:addView("detailNewsView", detailNewsView:new())
  -- Present the main view to the screen
  vc:presentView("categories")
end

-- Run the onStart() function. This has to be removed when running on the STB.
-- The LuaEngine on the STB will call this function by itself.
onStart()
