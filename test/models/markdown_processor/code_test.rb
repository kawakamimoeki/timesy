require "test_helper"

class MarkdownProcessor::CodeTest < ActiveSupport::TestCase
  test "class" do
    result = MarkdownProcessor::Code.process("<code class=\"ruby\"></code>")
    assert_equal "<code class=\"language-ruby\"></code>", result
  end

  test "no class" do
    result = MarkdownProcessor::Code.process("<code></code>")
    assert_equal "<code></code>", result
  end

  test "multiple" do
    result = MarkdownProcessor::Code.process("<code class=\"ruby\"></code><code class=\"typescript\"></code>")
    assert_equal "<code class=\"language-ruby\"></code><code class=\"language-typescript\"></code>", result
  end

  test "pre" do
    result = MarkdownProcessor::Code.process("<pre><code class=\"ruby\"></code></pre>")
    assert result.include?("<pre class=\"relative group\" data-controller=\"code-block\">")
  end
end
