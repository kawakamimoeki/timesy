require "test_helper"

class MarkdownProcessor::Emoji::HtmlTest < ActiveSupport::TestCase
  test "only emoji" do
    html = MarkdownProcessor::Emoji::Html.process("👍")
    assert_equal %(<span class="emoji" title="+1">👍</span>), html
  end

  test "not only emoji" do
    html = MarkdownProcessor::Emoji::Html.process("テスト 👍")
    assert_equal %(テスト <span class="emoji" title="+1">👍</span>), html
  end
end
