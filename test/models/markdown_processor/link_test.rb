require "test_helper"

class MarkdownProcessor::LinkTest < ActiveSupport::TestCase
  test "replace" do
    result = MarkdownProcessor::Link.process("<a href=\"#\"></a>")
    assert_equal "<a href=\"#\" data-turbo=\"false\"></a>", result
  end

  test "multiple" do
    result = MarkdownProcessor::Link.process("<a href=\"#\"></a><a href=\"#\"></a>")
    assert_equal "<a href=\"#\" data-turbo=\"false\"></a><a href=\"#\" data-turbo=\"false\"></a>", result
  end

  test "data-turbo true" do
    result = MarkdownProcessor::Link.process("<a href=\"#\" data-turbo=\"true\"></a>")
    assert_equal "<a href=\"#\" data-turbo=\"false\"></a>", result    
  end

  test "data-turbo false" do
    result = MarkdownProcessor::Link.process("<a href=\"#\" data-turbo=\"false\"></a>")
    assert_equal "<a href=\"#\" data-turbo=\"false\"></a>", result    
  end
end
