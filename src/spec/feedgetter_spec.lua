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

    local feeds = getter:parseFeeds(examplefile)

    --To check if it worked we simply check if we have some feeds
    assert.is_true(#feeds.entries > 0)

    for i, feed in ipairs(feeds.entries) do
      assert.not_same(nil, feed.title)
      assert.not_same(nil, feed.summary)
      assert.not_same(nil, feed.link)
      assert.not_same(nil, feed.date)

    end

  end)

it("Download and parse recent CNN feeds", function()

    local CNNLink = "http://rss.cnn.com/rss/edition_europe.rss"

    local getter = FeedGetter:new()

    getter:downloadFeeds(CNNLink, testfile)
    local feeds = getter:parseFeeds(testfile)

    --To check if it worked we simply check if we have some feeds
    assert.is_true(#feeds.entries > 0)

    for i, feed in ipairs(feeds.entries) do
      assert.not_same(nil, feed.title)
      assert.not_same(nil, feed.summary)
      assert.not_same(nil, feed.link)
      assert.not_same(nil, feed.date)

    end

  end)

it("Download and parse BBC feeds", function()

    local BBCLink = "http://feeds.bbci.co.uk/news/world/europe/rss.xml"

    local getter = FeedGetter:new()

    getter:downloadFeeds(BBCLink, testfile)
    local feeds = getter:parseFeeds(testfile)

    --To check if it worked we simply check if we have some feeds
    assert.is_true(#feeds.entries > 0)

    for i, feed in ipairs(feeds.entries) do
      assert.not_same(nil, feed.title)
      assert.not_same(nil, feed.summary)
      assert.not_same(nil, feed.link)
      assert.not_same(nil, feed.date)

    end

  end)



end)