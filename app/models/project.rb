class Project < ApplicationRecord
  include Markdownable

  belongs_to :user
  has_and_belongs_to_many :posts
  has_one_attached :icon
  has_many_attached :images

  validates :title, presence: true
  validates :codename, presence: true, uniqueness: { scope: :user_id }
  validates :link, url: { allow_blank: true }

  def icon_url
    if icon.attached?
      if ENV["CLOUDINARY_CLOUD_NAME"].present? && ENV["CLOUDINARY_API_KEY"].present? && ENV["CLOUDINARY_API_SECRET"].present?
        Cloudinary::Utils.cloudinary_url(icon.key, width: 150, height: 150, crop: :fill)
      else
        icon
      end
    else
      "https://api.dicebear.com/6.x/shapes/svg?seed=#{codename}"
    end
  end
end
