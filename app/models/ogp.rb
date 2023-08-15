class Ogp
  attr_reader :title, :description, :image, :url

  def initialize(data)
    if data[:title].is_a?(String)
      @title = data[:title]&.scrub('?')
    elsif data[:title].is_a?(Array)
      @title = data[:title].first&.scrub('?')
    else
      @title = nil
    end
    @description = data[:description]&.scrub('?')
    @image = data[:image]
    @url = data[:url]
  end

  def host
    @host ||= URI.parse(@url).host
  end

  def truncated_title
    @title&.truncate(64)
  end

  def truncated_description
    @description&.truncate(64)
  end
end
