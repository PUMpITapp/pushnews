require "feeds.feedgetter"
require "feeds.cnnNews"

local testfile = "feeds/test.xml"

describe("CNNNews:", function()

it("Download and parse all CNN feed categories and their articles", function()

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

        --Uncomment if you want to check all the news text (it takes ALOT of time)
        --print (feed.link)
        --local text = news:getArticleText(feed.link)
        --assert.not_same(nil, text)
        --print (text)

      end
    end

  end)

it("Download a CNN Article into an html file", function()

    local news = CNNNews:new()
    local link = 'http://edition.cnn.com/2014/11/10/world/europe/russia-nato-new-cold-war/index.html'
    local output = 'feeds/test.html'

    os.remove(output)

    news:downloadArticle(link, output)

    local file = io.open (testfile, "r")
    local size = file:seek("end")
    io.close(file)

    --We check the file size to see if we got any result
    assert.is_true(size > 0)

  end)

it("Download a CNN Article and return the article text", function()

    local news = CNNNews:new()
    local link = 'http://edition.cnn.com/2014/11/10/world/europe/russia-nato-new-cold-war/index.html'

    text = news:getArticleText(link)

    assert.not_same(nil, text)

  end)

end)