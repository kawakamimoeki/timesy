require "coderay"

module Markdownable
  extend ActiveSupport::Concern

  def truncated(length = 64)
    MarkdownProcessor::Truncate.process(body, length)
  end

  def html(length = false)
    MarkdownProcessor.process(body, length)
  end

  def purge_cache
    Rails.cache.delete(
      "/markdown/#{MarkdownProcessor::VERSION}/#{Digest::SHA256.hexdigest(body)}"
    )
  end
end
