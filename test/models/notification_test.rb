require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  test "link to user" do
    notification = Notification.new(subjectable: follows(:one))
    assert_equal "/test", notification.link
  end

  test "link to post" do
    comment = comments(:general)
    notification = Notification.new(subjectable: comment)
    assert_equal "/posts/#{comment.post.id}", notification.link
  end

  test "link to post reaction" do
    reaction = post_reactions(:general)
    notification = Notification.new(subjectable: reaction)
    assert_equal "/posts/#{reaction.post.id}", notification.link
  end

  test "link to comment reaction" do
    reaction = comment_reactions(:general)
    notification = Notification.new(subjectable: reaction)
    assert_equal "/posts/#{reaction.comment.post.id}", notification.link
  end

  test "#message" do
    notification = Notification.new(subjectable: follows(:one))
    assert_equal "<span class='font-bold'>Taro Test</span><span class='opacity-50'>さんにフォローされました</span>", notification.message
  end
end
