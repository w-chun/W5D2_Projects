class User < ApplicationRecord
  validates :username, :session_token, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}
  validates :username, :session_token, uniqueness: true

  attr_reader :password

  after_initialize :ensure_session_token

  has_many :subs,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Sub

  has_many :post,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Post

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.find_by_credentials(username, password)
    @user = User.find_by(username: username)
    if @user && @user.is_password?(password)
      @user
    else
      nil
    end
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
end
