require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "should attach projects" do
    user = users(:general)
    post = Post.create(body: "#test", user: user)
    post.attach_projects!
    assert_equal 1, post.projects.count
  end

  test "should not attach projects if projects are already attached" do
    user = users(:general)
    project = projects(:general)
    post = Post.create(body: "#test", user: user, projects: [project])
    post.attach_projects!
    assert_equal 1, post.projects.count
  end

  test "should attach multiple projects" do
    user = users(:general)
    project1 = projects(:general)
    project2 = projects(:general2)
    post = Post.create(body: "#test #test2", user: user, projects: [project1])
    post.attach_projects!
    assert_equal 2, post.projects.count
  end

  test "should get followings posts with followee and self and not other" do
    user = users(:general)
    followee = users(:general2)
    user2 = users(:general3)

    post = Post.create(body: "#test", user: followee)
    post2 = Post.create(body: "#test", user: user)
    post3 = Post.create(body: "#test", user: user2)

    assert Post.following(user).include?(post)
    assert Post.following(user).include?(post2)
    assert Post.following(user).exclude?(post3)
  end
end
