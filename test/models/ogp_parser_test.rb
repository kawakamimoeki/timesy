require "test_helper"

class OgpParserTest < ActiveSupport::TestCase
  test "parse" do
    html = <<~HTML
      <html>
        <title>タイトル</title>
        <meta name="description" content="説明">
        <meta property="og:title" content="タイトル">
        <meta property="og:description" content="説明">
        <meta property="og:image" content="https://example.com/image.png">
        <meta property="og:url" content="https://example.com">
      </html>
    HTML

    assert_equal(
      OgpParser.parse(html, "https://example.com"),
      { title: "タイトル", description: "説明", image: "https://example.com/image.png", url: "https://example.com" }
    )
  end

  test "no og:title" do
    html = <<~HTML
      <html>
        <title>タイトル</title>
        <meta name="description" content="説明">
        <meta property="og:description" content="説明">
        <meta property="og:image" content="https://example.com/image.png">
        <meta property="og:url" content="https://example.com">
      </html>
    HTML

    assert_equal(
      OgpParser.parse(html, "https://example.com"),
      { title: "タイトル", description: "説明", image: "https://example.com/image.png", url: "https://example.com" }
    )
  end

  test "no og:description" do
    html = <<~HTML
      <html>
        <title>タイトル</title>
        <meta property="og:title" content="タイトル">
        <meta name="description" content="説明">
        <meta property="og:image" content="https://example.com/image.png">
        <meta property="og:url" content="https://example.com">
      </html>
    HTML

    assert_equal(
      OgpParser.parse(html, "https://example.com"),
      { title: "タイトル", description: "説明", image: "https://example.com/image.png", url: "https://example.com" }
    )
  end

  test "no og:url" do
    html = <<~HTML
      <html>
        <title>タイトル</title>
        <meta name="description" content="説明">
        <meta property="og:title" content="タイトル">
        <meta property="og:description" content="説明">
        <meta property="og:image" content="https://example.com/image.png">
      </html>
    HTML

    assert_equal(
      OgpParser.parse(html, "https://example.com"),
      { title: "タイトル", description: "説明", image: "https://example.com/image.png", url: "https://example.com" }
    )
  end

  test "no og:image" do
    html = <<~HTML
      <html>
        <title>タイトル</title>
        <meta name="description" content="説明">
        <meta property="og:title" content="タイトル">
        <meta property="og:description" content="説明">
      </html>
    HTML

    assert_equal(
      OgpParser.parse(html, "https://example.com"),
      { title: "タイトル", description: "説明", image: "", url: "https://example.com" }
    )
  end
end
