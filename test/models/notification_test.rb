require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  test "link to user" do
    notification = Notification.new(subjectable: follows(:from_other))
    assert_equal "/test", notification.link
  end

  test "link to post" do
    comment = comments(:to_my_post)
    notification = Notification.new(subjectable: comment)
    assert_equal "/posts/#{comment.post.id}", notification.link
  end

  test "link to post reaction" do
    reaction = post_reactions(:to_other_post)
    notification = Notification.new(subjectable: reaction)
    assert_equal "/posts/#{reaction.post.id}", notification.link
  end

  test "link to comment reaction" do
    reaction = comment_reactions(:to_others_comment)
    notification = Notification.new(subjectable: reaction)
    assert_equal "/posts/#{reaction.comment.post.id}", notification.link
  end

  test "#message" do
    notification = Notification.new(subjectable: follows(:from_other))
    assert_equal "<span class='font-bold'>Taro Test</span><span class='opacity-50'>さんにフォローされました</span>", notification.message
  end
end
