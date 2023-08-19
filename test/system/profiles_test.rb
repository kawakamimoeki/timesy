require "application_system_test_case"

class ProfilesTest < ApplicationSystemTestCase
  def setup
    @page = @playwright_page
  end

  test "viewing posts" do
    @page.goto(user_path(users(:general).username))
    @page.wait_for_selector('[aria-label="View posts"]').click

    assert @page.text_content('[aria-label="Post"]').include?(posts(:general).body)
  end

  test "viewing comments" do
    @page.goto(user_path(users(:general).username))
    @page.wait_for_selector('[aria-label="View comments"]').click

    assert @page.text_content('[aria-label="Post"]').include?(posts(:general).body)
  end

  test "viewing projects" do
    @page.goto(user_path(users(:general).username))
    @page.wait_for_selector('[aria-label="View projects"]').click

    assert @page.text_content('[aria-label="Project"]').include?(projects(:general).title)
  end
end
