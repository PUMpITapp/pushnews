require "feeds.feedgetter"
require "feeds.cnnNews"
require "feeds.download"

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
  
        if i < 2 then
          local text = news:getArticleText(feed.link)
          assert.not_same(nil, text)
          --assert.not_same('', text)
        end
      end
    end

  end)

it("Download a CNN Article into an html file", function()

    local news = CNNNews:new()
    local link = 'http://edition.cnn.com/2014/11/10/world/europe/russia-nato-new-cold-war/index.html'
    local output = 'feeds/test.html'

    os.remove(output)

    download.downloadFile(link, output)

    local file = io.open (testfile, "r")
    local size = file:seek("end")
    io.close(file)

    --We check the file size to see if we got any result
    assert.is_true(size > 0)

  end)

it("Download a CNN Article and return the article text", function()

    local news = CNNNews:new()
    local link = 'http://edition.cnn.com/2014/11/11/travel/levison-wood-walking-nile/index.html'

    text = news:getArticleText(link)

    assert.not_same(nil, text)
    assert.not_same('', text)

  end)

it("Download a CNN Article from money.cnn and return the article text", function()

    local news = CNNNews:new()
    local link = 'http://money.cnn.com/2014/11/25/news/drone-pilot-degree/index.html?section=money_news_international'

    text = news:getArticleText(link)

    assert.not_same(nil, text)
    assert.not_same('', text)

  end)

it("parse and existing article html file", function()

    local news = CNNNews:new()
    local file = 'feeds/exampleCNN.html'

    text = news:parseArticleFile(file)

    assert.not_same(nil, text)
    assert.not_same('', text)

  end)

end)