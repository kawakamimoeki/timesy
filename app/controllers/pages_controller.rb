class PagesController < ApplicationController
  def privacy
    set_cache_control_headers
    @content = set_content("privacy")
  end

  def terms
    set_cache_control_headers
    @content = set_content("terms")
  end

  def docs
    set_cache_control_headers
    @content = set_content("docs")
  end

  def about
    set_cache_control_headers
  end

  private def set_content(type)
    begin
      file = File.read(Rails.root.join("app", "assets", type, I18n.locale.to_s + ".md.erb"))
    rescue Errno::ENOENT
      file = File.read(Rails.root.join("app", "assets", type, "en.md.erb"))
    end
    erb = ERB.new(file).result(binding)
    MarkdownProcessor.process(erb).html_safe
  end
end
