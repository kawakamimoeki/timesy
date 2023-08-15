class MarkdownProcessor
  module Emoji
    class Shortcode
      def self.process(markdown)
        return "" if markdown.nil?
        markdown.gsub(/:(.*):/) do
          ::Emoji.find_by_alias($1) ? ::Emoji.find_by_alias($1).raw : $&
        end
      end
    end
  end
end
