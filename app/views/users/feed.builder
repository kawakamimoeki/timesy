require 'rexml/document'
cache "/feed/202308201138/#{@user.username}", expires_in: 5.minutes do
  xml.instruct! :xml, :version => "1.0"
  xml.rss :version => "2.0", 'xmlns:dc': 'http://purl.org/dc/elements/1.1/', "xmlns:content": "http://purl.org/rss/1.0/modules/content/", "xmlns:atom": "http://www.w3.org/2005/Atom" do
    xml.channel do
      xml.title REXML::Document.new.tap { |doc| doc.add(REXML::CData.new("Timesy/#{@user.name}")) }.to_s
      xml.description REXML::Document.new.tap { |doc| doc.add(REXML::CData.new("Timesyの#{@user.name}さんのフィード")) }.to_s
      xml.link user_url(@user.username)
      xml.language "ja"
      xml.lastBuildDate @posts.first ? @posts.first.updated_at.to_s(:rfc822) : @user.created_at.to_s(:rfc822)
      xml.generator "Timesy"
      xml.ttl 30
      xml.image do
        xml.url "https://timesy.dev/logo.png"
        xml.title REXML::Document.new.tap { |doc| doc.add(REXML::CData.new("Timesy/#{@user.name}")) }.to_s
        xml.link user_url(@user.username)
      end
      xml.tag!('atom:link', rel: "self", type: "application/rss+xml", href: feed_url(@user.username))

      @posts.each do |p|
        xml.item do
          xml.title REXML::Document.new.tap { |doc| doc.add(REXML::CData.new(p.truncated)) }.to_s
          xml.description REXML::Document.new.tap { |doc| doc.add(REXML::CData.new(p.truncated(256))) }.to_s
          xml.pubDate p.updated_at.to_s(:rfc822)
          xml.link post_url(p)
          xml.guid post_url(p)
          xml.enclosure url: CGI.escape(ogp_image(p)), type: "image/jpeg", length: "0"
          p.projects.each do |proj|
            xml.category REXML::Document.new.tap { |doc| doc.add(REXML::CData.new(proj.title)) }.to_s, domain: project_url(@user.username, proj)
          end
          xml.tag!('dc:creator', @user.name)
        end
      end
    end
  end
end
