require "hello.hello"

describe("some asserts", function()
  it("checks if they're equals", function()
    local expected = "Hello Jack"
    local got = greet("Jack")

    assert.are.equals(expected, got)
  end)
end)
