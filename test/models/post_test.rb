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
end
