class Cheer < ApplicationRecord
  has_many :cheer_reactions, dependent: :destroy
end
