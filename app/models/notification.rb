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
    return nil if subjectable.nil?
    if subjectable_type == 'Follow'
      Rails.application.routes.url_helpers.user_path(subjectable.follower.username)
    elsif subjectable_type == 'Comment'
      Rails.application.routes.url_helpers.post_path(subjectable.post)
    elsif subjectable_type == 'Cheer'
      Rails.application.routes.url_helpers.post_path(subjectable.post)
    elsif subjectable_type == 'PostReaction'
      Rails.application.routes.url_helpers.post_path(subjectable.post)
    elsif subjectable_type == 'CommentReaction'
      Rails.application.routes.url_helpers.post_path(subjectable.comment.post)
    elsif subjectable_type == 'CheerReaction'
      Rails.application.routes.url_helpers.post_path(subjectable.cheer.post)
    elsif subjectable_type == 'Pin'
      Rails.application.routes.url_helpers.post_path(subjectable.post)
    end
  end

  def message
    if subjectable_type == 'Follow'
      I18n.t('notifications.follow', user: subjectable.follower.name)
    elsif subjectable_type.in?(['Cheer', 'Comment'])
      I18n.t('notifications.comment', user: subjectable.user.name, post: subjectable.post.truncated(16))
    elsif subjectable_type.in?(['PostReaction'])
      I18n.t('notifications.reaction', user: subjectable.user.name, target: subjectable.post.truncated(16))
    elsif subjectable_type.in?(['CommentReaction'])
      I18n.t('notifications.reaction', user: subjectable.user.name, target: subjectable.comment.truncated(16))
    elsif subjectable_type.in?(['CheerReaction'])
      I18n.t('notifications.reaction', user: subjectable.user.name, target: subjectable.cheer.truncated(16))
    elsif subjectable_type == 'Pin'
      I18n.t('notifications.pin', user: subjectable.user.name, post: subjectable.post.truncated(16))
    end
  end
end
