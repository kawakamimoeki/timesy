require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "username_with_at returns username with @" do
    user = users(:general)
    assert_equal "@test", user.username_with_at
  end

  test "avatar_icon returns avatar when attached" do
    user = users(:general)
    user.avatar.attach(io: File.open(Rails.root.join("test/fixtures/files/avatar.png")), filename: "avatar.png")
    assert_equal user.avatar, user.avatar_icon
  end

  test "avatar_icon returns dicebear when not attached" do
    user = users(:general)
    assert_equal "https://api.dicebear.com/6.x/thumbs/svg?seed=test", user.avatar_icon
  end
end
