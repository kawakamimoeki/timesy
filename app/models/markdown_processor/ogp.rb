class MarkdownProcessor
  class Ogp
    VERSION = "202308142311"

    def self.process(html)
      doc = Nokogiri::HTML::DocumentFragment.parse(html)
      doc.css('p').each do |paragraph|
        if paragraph.children.length == 1 && paragraph.children.first.name == "a"
          link = paragraph.children.find { |child| child.name == "a" }
          if link.text.match?(/twitter\.com\/\w+\/status\/\d+/)
            link.replace(ApplicationController.renderer.render(partial: "shared/tweet_card", locals: { url: link.text }))
          else
            data = Rails.cache.fetch("/ogp/#{VERSION}/#{Digest::SHA256.hexdigest(link.text)}", expires_in: 1.week) do
              response = Faraday.get(link.text)
              ogp = ::OGP::OpenGraph.new(response.body)
              ogp.data
            rescue
              false
            end
            if data
              link.replace(ApplicationController.renderer.render(partial: "shared/link_card", locals: { ogp: ::Ogp.new(data) }))
            end
          end
        end
      end
      doc.to_s
    end
  end
end
