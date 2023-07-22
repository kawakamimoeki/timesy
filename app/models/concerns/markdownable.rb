require "coderay"

module Markdownable
  extend ActiveSupport::Concern

  def html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, fenced_code_blocks: true)
    doc = Nokogiri::HTML::DocumentFragment.parse(markdown.render(emojified_body))
    doc.css('code[@class]').each do |code|
      div = ::CodeRay.scan(code.text.rstrip, code[:class].to_sym).div
      code = code.replace(div)
      code.first.parent.swap(code.first)
    end
    doc.to_s
  end

  def emojified_body
    body.gsub(/:(.*):/) do
      ::Emoji.find_by_alias($1) ? ::Emoji.find_by_alias($1).raw : $&
    end
  end

  def emoji_only?
    emojis = emojified_body.scan(Unicode::Emoji::REGEX)
    emojis.join == emojified_body.chomp
  end
end
