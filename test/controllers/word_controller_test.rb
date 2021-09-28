require 'test_helper'

class WordControllerTest < ActionDispatch::IntegrationTest
  test "can see the welcome page" do
    get "/word"
    assert "h1"
  end
end
