require "application_system_test_case"

class CreatePostsTest < ApplicationSystemTestCase
  def setup
    @page = @playwright_page
  end

  test "visiting the index" do
    ApplicationController.stub_any_instance :current_user,users(:current) do
      @page.goto(root_path)

      @page.wait_for_selector('.CodeMirror').click
      @page.keyboard.type('Hello, world!')
      @page.wait_for_selector('[data-testid="publish-post"]').click

      assert @page.wait_for_selector("[data-testid=\"Hello, world!\"]").text_content.include?("Hello, world!")
    end
  end
end
