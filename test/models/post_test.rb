require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "should attach projects" do
    user = users(:current)
    post = Post.create(body: "#test", user: user)
    post.attach_projects!
    assert_equal 1, post.projects.count
  end

  test "should not attach projects if projects are already attached" do
    user = users(:current)
    project = projects(:my_project)
    post = Post.create(body: "#test", user: user, projects: [project])
    post.attach_projects!
    assert_equal 1, post.projects.count
  end

  test "should attach multiple projects" do
    user = users(:current)
    project1 = projects(:my_project)
    project2 = projects(:others_project)
    post = Post.create(body: "#test #test2", user: user, projects: [project1])
    post.attach_projects!
    assert_equal 1, post.projects.count
  end

  test "should get followings posts with followee and self and not other" do
    user = users(:current)
    followee = users(:other)
    user2 = users(:other2)

    post = Post.create(body: "#test", user: followee)
    post2 = Post.create(body: "#test", user: user)
    post3 = Post.create(body: "#test", user: user2)

    assert Post.following(user).include?(post)
    assert Post.following(user).include?(post2)
    assert Post.following(user).exclude?(post3)
  end

  test "score per day" do
    user = users(:current)
    post = Post.create(body: "#test", user: user, created_at: 1.day.ago)
    post2 = Post.create(body: "#test", user: user, created_at: 1.day.ago)
    post3 = Post.create(body: "#test", user: user, created_at: 2.day.ago)
    post4 = Post.create(body: "#test", user: user, created_at: 2.day.ago)
    post5 = Post.create(body: "#test", user: user, created_at: 2.day.ago)
    post6 = Post.create(body: "#test", user: user, created_at: 2.day.ago)
    post7 = Post.create(body: "#test", user: user, created_at: 3.day.ago)
    post8 = Post.create(body: "#test", user: user, created_at: 3.day.ago)
    post9 = Post.create(body: "#test", user: user, created_at: 3.day.ago)
    
    assert_equal 1, Post.score_per_day(user)[1.day.ago.to_date]
    assert_nil Post.score_per_day(user)[5.day.ago.to_date]
  end
end
