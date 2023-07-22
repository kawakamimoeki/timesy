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
    assert_equal "<h1>Hello 😄</h1>\n", post.html
  end

  test "#emojified_body replace emoji when match" do
    post = TestPost.new(body: "Hello :smile:")
    assert_equal "Hello 😄", post.emojified_body
  end

  test "#emojified_body does not replace emoji when no match" do
    post = TestPost.new(body: "Hello :hoge:")
    assert_equal "Hello :hoge:", post.emojified_body
  end

  test "#emoji_only? returns true when body is emoji only" do
    post = TestPost.new(body: ":+1:")
    assert_equal post.emoji_only?, true
  end

  test "#emoji_only? returns false when body is not emoji only" do
    post = TestPost.new(body: ":+1: Hello")
    assert_equal post.emoji_only?, false
  end
end
