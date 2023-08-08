class PagesController < ApplicationController
  def privacy
    @content = set_content("privacy")
  end

  def terms
    @content = set_content("terms")
  end

  def docs
    @content = set_content("docs")
  end

  def about
  end

  private def set_content(type)
    file = File.read(Rails.root.join("app", "assets", type, I18n.locale.to_s + ".md.erb"))
    erb = ERB.new(file).result(binding)
    Rails.cache.fetch("/#{type}/#{Digest::SHA256.hexdigest(erb)}", expires_in: 1.week) do
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
      doc = Nokogiri::HTML::DocumentFragment.parse(markdown.render(erb))
      doc.css('code[@class]').each do |code|
        code[:class] = "language-" + code[:class]
      end
      doc.css('a').each do |link|
        link["data-turbo"] = false
      end
      doc.to_s.html_safe
    end
  end
end
