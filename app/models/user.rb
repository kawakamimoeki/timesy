class User < ApplicationRecord
  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :name, exclusion: { in: %w(posts users sign_up confirm register settings comments about privacy terms new-user notifications t) }
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
      avatar
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
