require "test_helper"

class ExportJobTest < ActiveJob::TestCase
  test "export job" do
    user = users(:general)
    assert_difference "Export.count", 1 do
      ExportJob.perform_now(user_id: user.id)
    end
  end
end
