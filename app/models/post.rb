class Post < ApplicationRecord
  include Markdownable

  belongs_to :user
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  has_many :post_reactions, dependent: :destroy

  scope :search, -> (q) { where("textsearchable_index_col @@ to_tsquery(?)", q) }
  scope :latest, -> { order(updated_at: :desc).limit(200) }

  def to_markdown
    <<~MARKDOWN
      ---
      created_at: #{created_at}
      updated_at: #{updated_at}
      ---

      #{body}

      ---

      #{comments.order(created_at: :asc).map { |c| c.body }.join("\n\n---\n\n")}

      --- 
    MARKDOWN
  end
end
