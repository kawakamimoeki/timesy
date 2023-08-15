require "test_helper"

class MarkdownProcessor::OgpTest < ActiveSupport::TestCase
  test "returns twitter card when body is twitter url" do
    result = MarkdownProcessor::Ogp.process("<p><a href=\"https://twitter.com/username/status/1234567890\">https://twitter.com/username/status/1234567890</a></p>")
    assert_equal %(<p><blockquote class="twitter-tweet"><a href="https://twitter.com/username/status/1234567890"></a></blockquote>\n</p>), result
  end
end
