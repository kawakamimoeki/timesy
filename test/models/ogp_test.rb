require "test_helper"

class OgpTest < ActiveSupport::TestCase
  test "host" do
    subject = Ogp.new({
      "url" => "https://moeki.dev",
    })
    assert_equal "moeki.dev", subject.host
  end

  test "host with path" do
    subject = Ogp.new({
      "url" => "https://moeki.dev/path/to",
    })
    assert_equal "moeki.dev", subject.host
  end

  test "host with query" do
    subject = Ogp.new({
      "url" => "https://moeki.dev/path/to?query=1",
    })
    assert_equal "moeki.dev", subject.host
  end

  test "host with fragment" do
    subject = Ogp.new({
      "url" => "https://moeki.dev/path/to#fragment",
    })
    assert_equal "moeki.dev", subject.host
  end

  test "host with port" do
    subject = Ogp.new({
      "url" => "https://moeki.dev:3000",
    })
    assert_equal "moeki.dev", subject.host
  end

  test "truncate description" do
    subject = Ogp.new({
      "description" => "a" * 100,
    })
    assert_equal "a" * 61 + "...", subject.truncated_description
  end

  test "truncate description with nil" do
    subject = Ogp.new({
      "description" => nil,
    })
    assert_nil subject.truncated_description
  end

  test "truncate description with short" do
    subject = Ogp.new({
      "description" => "a" * 10,
    })
    assert_equal "a" * 10, subject.truncated_description
  end
end
