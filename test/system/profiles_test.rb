require "application_system_test_case"

class ProfilesTest < ApplicationSystemTestCase
  def setup
    @page = @playwright_page
  end

  test "viewing posts" do
    @page.goto(user_path(users(:current).username))
    @page.wait_for_selector('[data-testid="view-posts"]').click

    assert @page.wait_for_selector('[data-testid="post-list"]').text_content.include?(posts(:my_post).body)
  end

  test "viewing projects" do
    @page.goto(user_path(users(:current).username))
    @page.wait_for_selector('[data-testid="view-projects"]').click

    assert @page.wait_for_selector('[data-testid="project-list"]').text_content.include?(projects(:my_project).title)
  end

  test "viewing followers" do
    @page.goto(user_path(users(:current).username))
    @page.wait_for_selector('[data-testid="view-followers"]').click

    assert @page.wait_for_selector('[data-testid="follower-list"]').text_content.include?(users(:other).name)
  end

  test "viewing followings" do
    @page.goto(user_path(users(:current).username))
    @page.wait_for_selector('[data-testid="view-following"]').click

    assert @page.wait_for_selector('[data-testid="following-list"]').text_content.include?(users(:other).name)
  end
end
