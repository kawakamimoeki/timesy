require "test_helper"

class WebfingerControllerTest < ActionDispatch::IntegrationTest
  test "acct:" do
    get webfinger_url, params: { resource: 'acct:test@timesy.dev' }
    assert_response :success
  end

  test "mailto:" do
    get webfinger_url, params: { resource: 'mailto:test@timesy.dev' }
    assert_response :success
  end

  test "https://timesy.dev/@" do
    get webfinger_url, params: { resource: 'https://timesy.dev/@test' }
    assert_response :success
  end

  test "https://timesy.dev/u/" do
    get webfinger_url, params: { resource: 'https://timesy.dev/u/test' }
    assert_response :success
  end

  test "https://timesy.dev/users/" do
    get webfinger_url, params: { resource: 'https://timesy.dev/users/test' }
    assert_response :success
  end

  test "https://timesy.dev/user/" do
    get webfinger_url, params: { resource: 'https://timesy.dev/user/test' }
    assert_response :success
  end

  test "404" do
    get webfinger_url, params: { resource: 'https://timesy.dev/user/test' }
    assert_response :success
  end
end
