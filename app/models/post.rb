class Post < ApplicationRecord
  include Markdownable

  belongs_to :user
  has_and_belongs_to_many :projects
  has_many :comments, dependent: :destroy
  has_many :post_reactions, dependent: :destroy
  has_many_attached :images
  has_many :pins, dependent: :destroy

  after_save -> { projects.each(&:touch) }

  scope :latest, -> { order(updated_at: :desc) }
  scope :following, -> (user) {where(user: user.followee_users).or(where(user: user)) }
  scope :pinned_by, -> (user) { joins(:pins).where(pins: {user: user}) }
  scope :trending, -> {
    joins(:post_reactions)
    .select('posts.*, count(post_reactions) as reaction_count')
    .group('posts.id')
    .order('reaction_count desc')
    .where('posts.created_at > ?', 1.week.ago)
  }

  def self.score_per_day(user)
    posts = Post
      .where(user: user)
      .group("created_at::DATE")
      .count
    comments = Comment
      .where(user: user)
      .group("created_at::DATE")
      .count
    count = posts.merge(comments)
    score = {}
    count.each do |date, c|
      if c == 0
        score[date] = 0
      elsif c > 0 && c <= 5
        score[date] = 1
      elsif c > 5 && c <= 10
        score[date] = 2
      elsif c > 10 && c <= 20
        score[date] = 3
      elsif c > 20 && c <= 30
        score[date] = 4
      elsif c > 30
        score[date] = 5
      end
    end
    score
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
