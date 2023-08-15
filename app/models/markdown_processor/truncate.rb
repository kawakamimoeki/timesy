class MarkdownProcessor
  class Truncate
    def self.process(markdown, length = 64)
      if length.is_a?(Integer)
        ActionController::Base.helpers.strip_tags(markdown).truncate(length)
      else
        markdown
      end
    end
  end
end
