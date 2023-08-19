cache 'feed_cache_key', expires_in: 30.minutes do
  xml.instruct! :xml, :version => "1.0"
  xml.rss :version => "2.0" do
    xml.channel do
      xml.title "<![CDATA[#{@user.name}さんのフィード]]>"
      xml.description "<![CDATA[Timesyの#{@user.name}さんのフィード]]>"
      xml.link user_url(@user.username)
      xml.language "ja"
      xml.atom :link, href: feed_url(@user.username, format: :atom), rel: "self", type: "application/rss+xml"
      xml.lastBuildDate @posts.first ? @posts.first.updated_at.to_s(:rfc822) : @user.created_at.to_s(:rfc822)
      xml.generator "Timesy"
      xml.ttl 30
      xml.image do
        xml.url "https://timesy.dev/logo.png"
        xml.title "#{@user.name}さんのフィード"
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
        end
      end
    end
  end
end
