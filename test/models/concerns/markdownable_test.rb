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
    assert_equal "<h1>Hello <span class=\"emoji\" title=\"smile\">😄</span></h1>\n", post.html
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

  test "#wrap_emoji returns html with emoji" do
    post = TestPost.new(body: "👍")
    assert_equal %(<span class="emoji" title="+1">👍</span>), post.wrap_emoji(post.body)
  end

  test "#wrap_project_tag returns html with project tag" do
    project = Project.create(codename: "test")
    post = TestPost.new(body: "#test")
    assert_equal %(<a href=\"/test/projects/test\" data-controller=\"tooltip\" data-tooltip-text-value=\"test @test\" data-turbo=\"false\" class=\"project-tag\">#test</a>), post.wrap_project_tag(post.body)
  end

  test "#html returns twitter card when body is twitter url" do
    post = TestPost.new(body: "https://twitter.com/username/status/1234567890")
    assert_equal %(<p><blockquote class="twitter-tweet"><a href="https://twitter.com/username/status/1234567890"></a></blockquote>\n</p>\n), post.html
  end
end
