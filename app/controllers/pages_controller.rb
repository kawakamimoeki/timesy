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
    @content = Kramdown::Document.new(erb, input: 'GFM').to_html.html_safe
  end
end
