class Cheer < ApplicationRecord
  include Markdownable

  belongs_to :user
  belongs_to :post
  has_many_attached :images
  has_many :cheer_reactions, dependent: :destroy

  scope :latest, -> { order(updated_at: :desc) }
end
