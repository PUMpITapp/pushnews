require "feeds.feeds"

local downloadURL = "http://rss.cnn.com/rss/edition_europe.rss"
local testfile = "feeds/test.xml"
local examplefile = "feeds/example.xml"


describe("Feeds:", function()
  it("check download of rss feed", function()

  	--We remove the file to make sure we managed to do something
  	os.remove(testfile)

    getter = FeedGetter:new()
    feeds = getter:downloadFeeds(downloadURL, testfile)

    file = io.open (testfile, "r")
    local size = file:seek("end")
    io.close(file)

    --We check the file size to see if we got any result
    assert.is_true(size > 0)

  end)

  it("Parse existing rss file", function()

    getter = FeedGetter:new()

    feeds = getter:parseFeeds(downloadURL, examplefile)

    --To check if it worked we simply check if we have some feeds
    assert.is_true(table.getn(feeds.entries) > 0)

  end)

end)