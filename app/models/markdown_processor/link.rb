class MarkdownProcessor
  class Link
    def self.process(markdown)
      doc = Nokogiri::HTML::DocumentFragment.parse(markdown)
      doc.css('a').each do |link|
        link["data-turbo"] = false
      end
      doc.to_s
    end
  end
end
