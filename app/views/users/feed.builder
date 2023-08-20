cache "/feed/#{@user.username}", expires_in: 5.minutes do
  xml.instruct! :xml, :version => "1.0"
  xml.rss :version => "2.0", 'xmlns:dc': 'http://purl.org/dc/elements/1.1/' do
    xml.channel do
      xml.title "<![CDATA[Timesy/#{@user.name}]]>"
      xml.description "<![CDATA[Timesyの#{@user.name}さんのフィード]]>"
      xml.link user_url(@user.username)
      xml.language "ja"
      xml.lastBuildDate @posts.first ? @posts.first.updated_at.to_s(:rfc822) : @user.created_at.to_s(:rfc822)
      xml.generator "Timesy"
      xml.ttl 30
      xml.image do
        xml.url "https://timesy.dev/logo.png"
        xml.title "Timesy/#{@user.name}"
        xml.link user_url(@user.username)
      end

      @posts.each do |p|
        xml.item do
          xml.title "<![CDATA[#{p.truncated}]]>"
          xml.description "<![CDATA[#{p.truncated(256)}]]>"
          xml.pubDate p.updated_at.to_s(:rfc822)
          xml.link post_url(p)
          xml.guid post_url(p)
          xml.enclosure url: CGI.escape(ogp_image(p)), type: "image/jpeg"
          p.projects.each do |proj|
            xml.category "<![CDATA[#{proj.title}]]>", domain: project_url(@user.username, proj)
          end
          xml.tag!('dc:creator', @user.name)
        end
      end
    end
  end
end
