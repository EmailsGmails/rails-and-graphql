# frozen_string_literal: true

class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@\s]+@[^@\s]+\z/
  CONFIRMATION_TOKEN_EXP = 30.minutes

  has_many :posts

  validates :password, presence: { on: :create }, length: { minimum: 8, maximum: 128 }
  validates :name, presence: true, on: :update
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: EMAIL_REGEXP

  before_save :encrypt_password, if: :password_changed?

  normalizes :email, with: -> { _1.strip.downcase }

  def generate_confirmation_token
    signed_id expires_in: CONFIRMATION_TOKEN_EXP, purpose: :confirm_email
  end

  private

  def encrypt_password
    self.password = BCrypt::Password.create(password)
  end
end
