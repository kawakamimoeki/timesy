class CommentReaction < ApplicationRecord
  belongs_to :comment, touch: true
  belongs_to :user
end
