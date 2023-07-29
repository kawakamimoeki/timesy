require "test_helper"

class PostExportSerializerTest < ActiveSupport::TestCase
  test "renders post as json" do
    post = posts(:general)
    expected = {
      body: post.body,
      author: post.user.username,
      created_at: post.created_at.iso8601,
      updated_at: post.updated_at.iso8601,
      comments: [
        {
          body: comments(:general).body,
          author: comments(:general).user.username,
          created_at: comments(:general).created_at.iso8601,
          updated_at: comments(:general).updated_at.iso8601
        }
      ],
    }.to_json
    assert_equal expected, PostExportSerializer.render(post)
  end
end
