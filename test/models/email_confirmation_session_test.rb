require "test_helper"

class EmailConfirmationSessionTest < ActiveSupport::TestCase
  test "token is generated on create" do
    session = EmailConfirmationSession.create(email: "test@example.com")
    assert session.token.present?
  end
end
