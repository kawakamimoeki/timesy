class MarkdownProcessor
  module Emoji
    class Html
      def self.process(markdown)
        markdown.gsub(Unicode::Emoji::REGEX) do |match|
          if emoji = ::Emoji.find_by_unicode(match)
            %(<span class="emoji" title="#{emoji.name}">#{match}</span>)
          else
            match
          end
        end
      end
    end
  end
end
