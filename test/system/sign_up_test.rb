require "application_system_test_case"

class SignUpTest < ApplicationSystemTestCase
  def setup
    @page = @playwright_page
  end

  test 'can prepare to sign up' do
    @page.goto("/")
    @page.wait_for_selector('[aria-label="Sign up"]').click

    @page.wait_for_selector('input[aria-label="Email"]').type("new@example.com")
    @page.wait_for_selector('input[aria-label="Send confirmation email"]').click
    
    assert @page.text_content('[aria-label="Notice"]').include?("確認メールを送信しました。メールに記載されたリンクをクリックしてください。")
  end
end
