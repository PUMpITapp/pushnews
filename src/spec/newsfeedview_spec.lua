require "main"

describe("New Feed View", function()
  it("Back to Categories", function()
    vc:getView("categories"):onKey("1","up")
    vc:getView("categories"):onKey("right","up")
    vc:getView("newsFeed"):onKey("left","up")
    local id,view = vc:getcurrentViewIdentifier()
    assert.are.equal(id,"categories")
  end)

  it("Up and Down", function()
    vc:getView("categories"):onKey("1","up")
    vc:getView("categories"):onKey("right","up")
    vc:getView("newsFeed"):onKey("left","up")
    
    vc:getView("newsFeed"):onKey("down","up")
    assert.are.equal(vc:getView("newsFeed").newsIndex,7)

    vc:getView("newsFeed"):onKey("up","up")
    assert.are.equal(vc:getView("newsFeed").newsIndex,1)

    --Back to categories view
    vc:getView("newsFeed"):onKey("left","up")
  end) 

  it("Sorted by Date", function()
    vc:getView("categories"):onKey("1","up")
    vc:getView("categories"):onKey("right","up")
    vc:getView("newsFeed"):onKey("left","up")

    local news1_date = vc:getView("newsFeed").news[1].date
    local news2_date = vc:getView("newsFeed").news[2].date

    assert.is_true(news1_date>news2_date)

     --Back to categories view
    vc:getView("newsFeed"):onKey("left","up")
  end) 

  it("Advertising Banner", function()
    vc:getView("categories"):onKey("green","up")
    vc:getView("categories"):onKey("1","up")
    vc:getView("categories"):onKey("right","up")

    assert.is_true(vc:getView("newsFeed").feedProvider.advertising)

    vc:getView("newsFeed"):onKey("left","up")
    vc:getView("categories"):onKey("red","up")
    vc:getView("categories"):onKey("1","up")
    vc:getView("categories"):onKey("right","up")

    assert.is_false(vc:getView("newsFeed").feedProvider.advertising)

     --Back to categories view
    vc:getView("newsFeed"):onKey("left","up")
  end)

  it("Select News", function()
    --vc:getView("categories"):onKey("green","up")
    --vc:getView("categories"):onKey("8","up")
    --vc:getView("categories"):onKey("right","up")
    --vc:getView("newsFeed"):onKey("1","up")
    --local id,view = vc:getcurrentViewIdentifier()
    --assert.are.equal(id,"detailNewsView")
  end)  
end) 