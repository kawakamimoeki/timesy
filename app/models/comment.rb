class Comment < ApplicationRecord
  include Markdownable

  belongs_to :user
  belongs_to :post, touch: true

  def to_markdown
    <<~MARKDOWN
      ---
      created_at: #{created_at}
      updated_at: #{updated_at}
      ---

      #{body}
    MARKDOWN
  end
end
