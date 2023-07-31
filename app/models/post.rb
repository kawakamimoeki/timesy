class Post < ApplicationRecord
  include Markdownable

  belongs_to :user
  has_and_belongs_to_many :projects
  has_many :comments, dependent: :destroy
  has_many :post_reactions, dependent: :destroy
  has_many_attached :images

  scope :search, -> (q) { where("textsearchable_index_col @@ to_tsquery(?)", q) }
  scope :latest, -> { order(updated_at: :desc).limit(200) }

  def attach_projects!
    body.scan(/#(\w+)/).flatten.each do |codename|
      project = user.projects.find_by(codename: codename)
      if project.present? && !projects.include?(project)
        projects << project
      end
    end

    save
  end
end
