class CheerReaction < ApplicationRecord
  belongs_to :user
  belongs_to :cheer
end
