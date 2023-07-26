class PagesController < ApplicationController
  def privacy
    set_content("privacy")
  end

  def terms
    set_content("terms")
  end

  private def set_content(type)
    file = File.read(Rails.root.join("app", "assets", type, I18n.locale.to_s + ".md.erb"))
    erb = ERB.new(file).result(binding)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    @content = markdown.render(erb).html_safe
  end
end
