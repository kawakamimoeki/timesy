require "coderay"

module Markdownable
  extend ActiveSupport::Concern

  def html(truncate = false)
    markdown = Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(
        filter_html: true,
        hard_wrap: true,
      ),
      autolink: true,
      tables: true,
      fenced_code_blocks: true,
      strikethrough: true,
      no_intra_emphasis: true,
      space_after_headers: true,
    )
    if truncate === false
      body = emojified_body
    else
      body = emojified_body.truncate(truncate)
    end
    doc = Nokogiri::HTML::DocumentFragment.parse(markdown.render(body))
    doc.css('code[@class]').each do |code|
      code[:class] = "language-" + code[:class]
    end
    doc.css('a').each do |link|
      link["data-turbo"] = false
    end
    wrap_emoji(doc.to_s)
  end

  def emojified_body
    return "" if body.nil?
    body.gsub(/:(.*):/) do
      ::Emoji.find_by_alias($1) ? ::Emoji.find_by_alias($1).raw : $&
    end
  end

  def emoji_only?
    emojis = emojified_body.scan(Unicode::Emoji::REGEX)
    emojis.join == emojified_body.chomp
  end

  def wrap_emoji(string)
    string.gsub(Unicode::Emoji::REGEX) do |match|
      if emoji = Emoji.find_by_unicode(match)
        %(<span class="emoji" title="#{emoji.name}">#{match}</span>)
      else
        match
      end
    end
  end
end
