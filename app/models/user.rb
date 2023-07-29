class User < ApplicationRecord
  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :exports, dependent: :destroy

  validates :name, presence: true
  validates :name, exclusion: {
    in: %w(
      posts users sign_up confirm register settings comments notifications api
      guide help support contact faq docs about privacy terms t
    )
  }
  validates :username, presence: true, uniqueness: true, format: { with: /\A[a-z0-9_]*\z/ }
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP }
  
  passwordless_with :email

  def username_with_at
    "@#{username}"
  end

  def avatar_icon
    if avatar.attached?
      if ENV["CLOUDINARY_CLOUD_NAME"].present? && ENV["CLOUDINARY_API_KEY"].present? && ENV["CLOUDINARY_API_SECRET"].present?
        Cloudinary::Utils.cloudinary_url(avatar.key, width: 150, height: 150, crop: :fill)
      else
        avatar
      end
    else
      "https://api.dicebear.com/6.x/thumbs/svg?seed=#{username}"
    end
  end

  def actor_json
    {
      "@context": "https://www.w3.org/ns/activitystreams",
      type: "Person",
      id: Site.origin + "/#{username}",
      name: username,
      inbox: Site.origin + "/#{username}/inbox",
      outbox: Site.origin + "/#{username}/outbox",
      publicKey: {
        "id": "#{Site.origin}/#{username}#main-key",
        "owner": "#{Site.origin}/#{username}",
        "publicKeyPem": ENV['ACTIVITY_PUB_PUBLIC_KEY']
      },
      icon: {
        type: 'Image',
        mediaType: 'image/png',
        url: avatar_icon
      },
      image: {
        type: 'Image',
        mediaType: 'image/png',
        url: avatar_icon
      }
    }.to_json
  end
end
