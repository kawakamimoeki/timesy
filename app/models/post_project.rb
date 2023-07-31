class PostProject < ApplicationRecord
  belongs_to :post
  belongs_to :project
end
