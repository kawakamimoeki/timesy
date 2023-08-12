class User < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :wallpaper
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :exports, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :followees, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, class_name: 'Follow', foreign_key: 'followee_id', dependent: :destroy
  has_many :followee_users, through: :followees, source: :followee
  has_many :follower_users, through: :followers, source: :follower
  has_many :notifications, dependent: :destroy
  has_many :access_tokens, dependent: :destroy
  has_many :pins, dependent: :destroy
  belongs_to :code_theme, optional: true

  validates :name, presence: true
  validates :name, exclusion: {
    in: %w(
      posts users sign_up confirm register settings comments notifications api search pinned latest following notifications
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

  def follow?(user)
    Follow.exists?(follower: self, followee: user)
  end

  def avatar_icon
    if avatar.attached?
      if ENV["CLOUDINARY_CLOUD_NAME"].present? && ENV["CLOUDINARY_API_KEY"].present? && ENV["CLOUDINARY_API_SECRET"].present?
        Cloudinary::Utils.cloudinary_url(avatar.key, width: 150, height: 150, crop: :fill, secure: true)
      else
        avatar
      end
    else
      "https://api.dicebear.com/6.x/thumbs/svg?seed=#{username}"
    end
  end

  def wallpaper_or_none
    if wallpaper.attached?
      wallpaper_url
    else
      no_wallpaper
    end
  end

  def no_wallpaper
    "https://res.cloudinary.com/dw1xpb7if/image/upload/v1691677320/lhr70ktzse7gzw1jtosw.png"
  end

  def wallpaper_url
    if ENV["CLOUDINARY_CLOUD_NAME"].present? && ENV["CLOUDINARY_API_KEY"].present? && ENV["CLOUDINARY_API_SECRET"].present?
      Cloudinary::Utils.cloudinary_url(wallpaper.key, crop: :fill, secure: true)
    else
      wallpaper
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
