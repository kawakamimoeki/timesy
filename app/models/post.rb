class Post < ApplicationRecord
  include Markdownable
  include MeiliSearch::Rails

  belongs_to :user
  has_and_belongs_to_many :projects
  has_many :comments, dependent: :destroy
  has_many :post_reactions, dependent: :destroy
  has_many_attached :images
  has_many :pins, dependent: :destroy

  scope :latest, -> { order(updated_at: :desc) }
  scope :following, -> (user) {where(user: user.followee_users).or(where(user: user)) }
  scope :pinned_by, -> (user) { joins(:pins).where(pins: {user: user}) }

  meilisearch do
    attribute :body

    attribute :user do
      user.name
    end

    attribute :username do
      user.username
    end
  end

  def attach_projects!
    projects.clear

    body.scan(/#(\w+)/).flatten.each do |codename|
      project = user.projects.find_by(codename: codename)
      if project.present? && !projects.include?(project)
        projects << project
      end
    end

    save
  end

  def pinned_by?(user)
    pins.where(user: user).exists?
  end
end
