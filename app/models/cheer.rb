class Cheer < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many_attached :images
  has_many :cheer_reactions, dependent: :destroy
end
