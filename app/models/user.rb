class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password

  validates :password, confirmation: true
  validates :password, on: :create, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  belongs_to :role
  has_many :orders

  def admin?
    role.name == 'administrator'
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    return nil  unless user
    hash_secret = BCrypt::Engine.hash_secret(password, user.password_salt)

    user if user.password_hash == hash_secret
  end

  def encrypt_password
    return unless password.present?

    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end
end
