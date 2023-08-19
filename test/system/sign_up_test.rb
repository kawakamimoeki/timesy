require "application_system_test_case"

class SignUpTest < ApplicationSystemTestCase
  def setup
    @page = @playwright_page
  end

  test 'can prepare to sign up' do
    @page.goto("/")
    @page.wait_for_selector('[data-testid="signup-link"]').click

    @page.wait_for_selector('[data-testid="email"]').type("new@example.com")
    @page.wait_for_selector('[data-testid="submit"]').click
    
    assert @page.wait_for_selector('[role="alert"]').text_content.include?("確認メールを送信しました。メールに記載されたリンクをクリックしてください。")
  end
end
