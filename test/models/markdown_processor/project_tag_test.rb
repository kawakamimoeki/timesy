require "test_helper"

class MarkdownProcessor::ProjectTagTest < ActiveSupport::TestCase
  test "returns html with project tag" do
    project = Project.create(codename: "test")
    result = MarkdownProcessor::ProjectTag.process("#test")
    assert_equal %(<a href=\"/test/projects/test\" data-controller=\"tooltip\" data-tooltip-text-value=\"test @test\" data-turbo=\"false\" class=\"project-tag\">#test</a>), result
  end
end
