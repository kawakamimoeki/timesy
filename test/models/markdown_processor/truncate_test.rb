require "test_helper"

class MarkdownProcessor::TruncateTest < ActiveSupport::TestCase
  test "truncate" do
    result = MarkdownProcessor::Truncate.process("これはテストです。", 6)
    assert_equal "これは...", result
  end

  test "not number" do
    result = MarkdownProcessor::Truncate.process("これはテストです。", nil)
    assert_equal "これはテストです。", result
  end
end
