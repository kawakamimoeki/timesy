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
    MarkdownProcessor.process(erb).html_safe
  end
end
