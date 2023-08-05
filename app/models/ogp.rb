class Ogp
  attr_reader :title, :description, :image, :url

  def initialize(data)
    @title = data["title"]&.scrub('?')
    @description = data["description"]&.scrub('?')
    @image = data["image"]
    @url = data["url"]
  end

  def host
    @host ||= URI.parse(@url).host
  end

  def truncated_title
    @title&.truncate(32)
  end

  def truncated_description
    @description&.truncate(64)
  end
end
