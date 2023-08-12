class Comment < ApplicationRecord
  include Markdownable
  include MeiliSearch::Rails

  belongs_to :user
  belongs_to :post, touch: true
  has_many :comment_reactions, dependent: :destroy
  has_many_attached :images

  scope :latest, -> { order(created_at: :desc) }
  scope :oldest, -> { order(created_at: :asc) }

  meilisearch enqueue: :trigger_job do
    attribute :body

    attribute :user do
      user.name
    end

    attribute :username do
      user.username
    end
  end

  def self.trigger_job(record, remove)
    MeilisearchIndexJob.perform_later(self, record.id, remove)
  end
end
