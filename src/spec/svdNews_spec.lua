require "feeds.feedgetter"
require "feeds.svdNews"
require "feeds.download"

local testfile = "feeds/test.xml"

describe("SVDNews:", function()

it("Download and parse all SVD feed categories and their articles", function()

    local getter = FeedGetter:new()
    local news = SVDNews:new()

    for cat in pairs(news.categories) do
      local url = news.categories[cat]

      os.remove(testfile)

      download.downloadFile(url, testfile)

      local feeds = getter:parseFeeds(testfile)

      --To check if it worked we simply check if we have some feeds
      assert.is_true(#feeds.entries > 0)

      for i, feed in ipairs(feeds.entries) do
        assert.not_same(nil, feed.title)
        assert.not_same(nil, feed.summary)
        assert.not_same(nil, feed.link)
        assert.not_same(nil, feed.date)

        --Uncomment if you want to check all the news text (it takes ALOT of time)

        --Test only a few links or it takes too much time
        if i < 3 then
          local text = news:getArticleText(feed.link)

          assert.not_same(nil, text)
          assert.not_same('', text)
        end
      end
    end

  end)

it("Download a SVD Article into an html file", function()

    local news = SVDNews:new()
    local link = 'http://www.svd.se/nyheter/utrikes/4131061.svd'
    local output = 'feeds/test.html'

    os.remove(output)

    download.downloadFile(link, output)

    local file = io.open (testfile, "r")
    local size = file:seek("end")
    io.close(file)

    --We check the file size to see if we got any result
    assert.is_true(size > 0)

  end)

it("Download a SVD Article and return the article text", function()

    local news = SVDNews:new()
    local link = 'http://www.svd.se/naringsliv/nyheter/norsk-oljeproduktion-minskas-inte_4131605.svd'

    text = news:getArticleText(link)

    assert.not_same(nil, text)
    assert.not_same('', text)

  end)

it("parse and existing article html file", function()

    local news = SVDNews:new()
    local file = 'feeds/exampleSVD.html'

    text = news:parseArticleFile(file)

    assert.not_same(nil, text)
    assert.not_same('', text)

  end)

end)