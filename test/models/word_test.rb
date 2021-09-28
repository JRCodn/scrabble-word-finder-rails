require 'test_helper'

class WordTest < ActiveSupport::TestCase
  test "should not save word without letters" do
    article = Word.new
    assert_not article.save, "Saved word without letters"
  end
end
