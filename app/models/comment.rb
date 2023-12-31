class Comment < ApplicationRecord
  include Markdownable

  belongs_to :user
  belongs_to :post, touch: true
  has_many :comment_reactions, dependent: :destroy
  has_many_attached :images

  scope :latest, -> { order(created_at: :desc) }
  scope :oldest, -> { order(created_at: :asc) }
end
