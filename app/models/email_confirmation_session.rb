class EmailConfirmationSession < ApplicationRecord
  validates :email, presence: true
  validates :timeout_at, presence: true
  validates :expires_at, presence: true
  validates :token, presence: true

  before_validation :set_defaults, on: :create

  scope :available, -> { where("expires_at > ?", Time.current) }

  def expired?
    expires_at <= Time.current
  end

  def timed_out?
    timeout_at <= Time.current
  end

  def claim!
    raise Errors::TokenAlreadyClaimedError if claimed?
    touch(:claimed_at)
  end

  def claimed?
    !!claimed_at
  end

  def available?
    !expired?
  end

  private def set_defaults
    self.expires_at = Passwordless.expires_at.call
    self.timeout_at = Passwordless.timeout_at.call
    self.token ||= loop {
      token = Passwordless.token_generator.call(self)
      break token unless EmailConfirmationSession.find_by(token: token)
    }
  end
end
