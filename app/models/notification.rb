class Notification < ApplicationRecord
  belongs_to :subjectable, polymorphic: true
  belongs_to :user

  scope :unread, -> { where(read_at: nil) }

  def read?
    read_at.present?
  end

  def read!
    update!(read_at: Time.zone.now)
  end

  def link
    if subjectable_type == 'Follow'
      Rails.application.routes.url_helpers.user_path(subjectable.follower.username)
    elsif subjectable_type == 'Comment'
      Rails.application.routes.url_helpers.post_path(subjectable.post)
    elsif subjectable_type == 'PostReaction'
      Rails.application.routes.url_helpers.post_path(subjectable.post)
    elsif subjectable_type == 'CommentReaction'
      Rails.application.routes.url_helpers.post_path(subjectable.comment.post)
    end
  end

  def message
    if subjectable_type == 'Follow'
      I18n.t('notifications.follow', user: subjectable.follower.name)
    elsif subjectable_type == 'Comment'
      I18n.t('notifications.comment', user: subjectable.user.name, post: subjectable.post.truncated(16))
    elsif subjectable_type == 'PostReaction'
      I18n.t('notifications.post_reaction', user: subjectable.user.name, post: subjectable.post.truncated(16))
    elsif subjectable_type == 'CommentReaction'
      I18n.t('notifications.comment_reaction', user: subjectable.user.name, comment: subjectable.comment.truncated(16))
    end
  end
end
