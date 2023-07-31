class Site
  def self.organization
    "Moeki Kawakami"
  end

  def self.email
    "hello@timesy.dev"
  end

  def self.title
    "Timesy"
  end

  def self.description
    I18n.t("site.description")
  end

  def self.origin
    ENV["SITE_ORIGIN"]
  end

  def self.sender_email
    ENV.fetch("SITE_SENDER_EMAIL", "Timesy <noreply@timesy.dev>")
  end
end
