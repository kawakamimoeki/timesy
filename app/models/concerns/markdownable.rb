require "coderay"

module Markdownable
  extend ActiveSupport::Concern

  def truncated(length = 64)
    MarkdownProcessor.process(body, length)
  end

  def html(length = false)
    MarkdownProcessor.process(body, length)
  end
end
