class MarkdownProcessor
  class Truncate
    def self.process(markdown, length = 64)
      if length.is_a?(Integer)
        markdown = Emoji::Shortcode.process(markdown)
        html = MarkdownProcessor.processor.render(markdown)
        ActionController::Base.helpers.strip_tags(strip_emoji(html)).gsub(/\n/, " ").gsub(/\//, "").truncate(length)
      else
        markdown
      end
    end

    def self.strip_emoji(body)
      return "" if body.nil?
      body.gsub(/#{Unicode::Emoji::REGEX}/, "") do
        $&
      end
    end
  end
end
