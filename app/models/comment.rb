class Comment < ApplicationRecord
  include Markdownable

  belongs_to :user
  belongs_to :post
end
