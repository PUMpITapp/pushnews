require "feeds.feedgetter"

local downloadURL = "http://rss.cnn.com/rss/edition_europe.rss"
local testfile = "feeds/test.xml"
local examplefile = "feeds/example.xml"


describe("FeedGetter:", function()
  it("check download of rss feed", function()

  	--We remove the file to make sure we managed to do something
  	os.remove(testfile)

    local getter = FeedGetter:new()
    local feeds = getter:downloadFeeds(downloadURL, testfile)

    local file = io.open (testfile, "r")
    local size = file:seek("end")
    io.close(file)

    --We check the file size to see if we got any result
    assert.is_true(size > 0)

  end)

  it("Parse existing rss file", function()

    local getter = FeedGetter:new()

    local feeds = getter:parseFeeds(downloadURL, examplefile)

    --To check if it worked we simply check if we have some feeds
    assert.is_true(table.getn(feeds.entries) > 0)

  end)

  it("Parse existing rss file AND retrieve it as standart feed array", function()

    local getter = FeedGetter:new()

    local parsed = getter:parseFeeds(downloadURL, examplefile)

    local feeds = getter:translateResult(parsed, 'CNN')

    --To check if it worked we simply check if we have some feeds
    assert.is_true(table.getn(feeds) > 0)

    for i, parsedFeed in ipairs(parsed.entries) do
          assert.are_not.equals(nil, feeds[i].title)
          assert.are_not.equals(nil, feeds[i].summary)
          assert.are_not.equals(nil, feeds[i].date)
          assert.are_not.equals(nil, feeds[i].source)
          assert.are_not.equals(nil, feeds[i].link)
    end
  end)

end)