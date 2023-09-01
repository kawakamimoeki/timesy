require "test_helper"

class PostExportSerializerTest < ActiveSupport::TestCase
  test "renders post as json" do
    post = posts(:my_post)
    expected = {
      id: post.id,
      body: post.body,
      author: post.user.username,
      created_at: post.created_at.iso8601,
      updated_at: post.updated_at.iso8601,
      comments: [
        {
          id: comments(:to_my_post).id,
          body: comments(:to_my_post).body,
          author: comments(:to_my_post).user.username,
          created_at: comments(:to_my_post).created_at.iso8601,
          updated_at: comments(:to_my_post).updated_at.iso8601
        },
        {
          id: comments(:from_other).id,
          body: comments(:from_other).body,
          author: comments(:from_other).user.username,
          created_at: comments(:from_other).created_at.iso8601,
          updated_at: comments(:from_other).updated_at.iso8601
        }
      ]
    }.to_json
    assert_equal expected, PostExportSerializer.render(post)
  end
end
