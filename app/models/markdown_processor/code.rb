class MarkdownProcessor
  class Code
    def self.process(html)
      doc = Nokogiri::HTML::DocumentFragment.parse(html)
      doc.css('code[@class]').each do |code|
        code[:class] = "language-" + code[:class]
      end
      doc.to_s
    end
  end
end
