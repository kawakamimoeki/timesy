require 'pygments'

module Markdownable
  extend ActiveSupport::Concern

  def html(truncate = false)
    if truncate === false
      body = emojified_body
    else
      body = emojified_body.truncate(truncate)
    end
    html = Rinku.auto_link(Kramdown::Document.new(body, input: 'GFM').to_html)
    doc = Nokogiri::HTML::DocumentFragment.parse(html)
    doc.css('code[@class]').each do |code|
      Pygments.highlight(code.text, lexer: code[:class].match(/language-(\w+)/)[1], options: { encoding: 'utf-8' })
    end
    doc.css('a').each do |link|
      link["data-turbo"] = false
    end
    doc = wrap_emoji(doc.to_s)
    doc = wrap_project_tag(doc)
    doc
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

  def wrap_project_tag(string)
    string.gsub(/#(\w+)/) do |match|
      if project = Project.find_by(codename: $1)
        %(<a href="/#{project.user.username}/projects/#{project.codename}" data-controller="tooltip" data-tooltip-text-value="#{project.title} @#{project.user.username}" data-turbo="false" class="project-tag">#{$&}</a>)
      else
        match
      end
    end
  end
end
