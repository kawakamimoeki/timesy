class PagesController < ApplicationController
  def privacy
    set_content("privacy")
  end

  def terms
    set_content("terms")
  end

  def docs
    set_content("docs")
  end

  def about
  end

  private def set_content(type)
    file = File.read(Rails.root.join("app", "assets", type, I18n.locale.to_s + ".md.erb"))
    erb = ERB.new(file).result(binding)
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
    @content = markdown.render(erb).html_safe
  end
end
