class OgpParser
  def self.parse(html, target_url)
    doc = Nokogiri::HTML::DocumentFragment.parse(html)

    data = {
      title: "",
      description: "",
      url: "",
      image: ""
    }

    doc.css("meta").each do |meta|
      case meta[:property]
      when "og:title" then
        data[:title] = meta[:content]
      when "og:description" then
        data[:description] = meta[:content]
      when "og:url" then
        data[:url] = meta[:content]
      when "og:image" then
        data[:image] = meta[:content]
      end
    end

    unless data[:title].present?
      data[:title] = doc.css("title")[0].text
    end

    unless data[:description].present?
      doc.css("meta").each do |meta|
        if meta[:name]&.downcase == "description"
          data[:description] = meta[:content]
        end
      end
    end

    unless data[:url].present?
      data[:url] = target_url
    end

    data
  end
end
