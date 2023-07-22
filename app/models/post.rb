class Post < ApplicationRecord
  include Markdownable

  belongs_to :user
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy

  scope :search, -> (q) { where("textsearchable_index_col @@ to_tsquery(?)", q) }
  scope :latest, -> { order(updated_at: :desc).limit(200) }
end
