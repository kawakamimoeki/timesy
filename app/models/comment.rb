class Comment < ApplicationRecord
  include Markdownable

  belongs_to :user
  belongs_to :post, touch: true
  has_many :comment_reactions, dependent: :destroy
  has_many_attached :images
end
