require "test_helper"

class MarkdownProcessor::ProjectTagTest < ActiveSupport::TestCase
  test "returns html with project tag" do
    project = Project.create(codename: "test")
    result = MarkdownProcessor::ProjectTag.process("<p>#test</p>")
    assert_equal %(<p><a href="/test/projects/test" data-controller="tooltip" data-tooltip-text-value="test @test" data-turbo="false" class="project-tag">#test</a></p>), result
  end

  test "not transform when it is not text content" do
    project = Project.create(codename: "test")
    result = MarkdownProcessor::ProjectTag.process(%(<p><a href="http://example.com/#test">test</a></p>))
    assert_equal %(<p><a href="http://example.com/#test">test</a></p>), result
  end
end
