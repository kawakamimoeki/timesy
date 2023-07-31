class PostReaction < ApplicationRecord
  belongs_to :post, touch: true
  belongs_to :user
end
