require "feeds.feedgetter"
require "feeds.cnnNews"

local testfile = "feeds/test.xml"

describe("CNNNews:", function()

it("Download and parse all CNN feed categories", function()

    local getter = FeedGetter:new()
    local news = CNNNews:new()

    for cat in pairs(news.categories) do
      local url = news.categories[cat]

      os.remove(testfile)

      getter:downloadFeeds(url, testfile)
      local feeds = getter:parseFeeds(testfile)

      --To check if it worked we simply check if we have some feeds
      assert.is_true(#feeds.entries > 0)

      for i, feed in ipairs(feeds.entries) do
        assert.not_same(nil, feed.title)
        assert.not_same(nil, feed.summary)
        assert.not_same(nil, feed.link)
        assert.not_same(nil, feed.date)

      end
    end

  end)



end)