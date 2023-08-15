class MarkdownProcessor
  class Ogp
    def self.process(html)
      doc = Nokogiri::HTML::DocumentFragment.parse(html)
      doc.css('p').each do |paragraph|
        if paragraph.children.length == 1 && paragraph.children.first.name == "a"
          link = paragraph.children.find { |child| child.name == "a" }
          if link.text.match?(/twitter\.com\/\w+\/status\/\d+/)
            link.replace(ApplicationController.renderer.render(partial: "shared/tweet_card", locals: { url: link.text }))
          else
            res = Faraday.get(link.text)
            data = OgpParser.parse(res.body, link.text)
            link.replace(ApplicationController.renderer.render(partial: "shared/link_card", locals: { ogp: ::Ogp.new(data) }))
          end
        end
      end
      doc.to_s
    end
  end
end
