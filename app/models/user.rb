class User < ApplicationRecord
  has_one_attached :avatar
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
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
end
