require "test_helper"

class TestPost
  include Markdownable

  attr_accessor :body

  def initialize(body:)
    @body = body
  end
end

class MarkdownableTest < ActiveSupport::TestCase
  test "#html returns html" do
    post = TestPost.new(body: "# Hello")
    assert_equal "<h1>Hello</h1>\n", post.html
  end

  test "#html returns html with emoji" do
    post = TestPost.new(body: "# Hello :smile:")
    assert_equal "<h1>Hello <span class=\"emoji\" title=\"smile\">😄</span>\n</h1>\n", post.html
  end
end
