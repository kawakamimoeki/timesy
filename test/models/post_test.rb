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
end
