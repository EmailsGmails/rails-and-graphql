# frozen_string_literal: true

class User < ApplicationRecord
  EMAIL_REGEXP = /\A[^@\s]+@[^@\s]+\z/
  CONFIRMATION_TOKEN_EXP = 30.minutes

  has_many :posts
  has_secure_password

  validates :password, presence: { on: :create }, length: { minimum: 8, maximum: 128 }
  validates :name, presence: true, on: :update
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: EMAIL_REGEXP

  normalizes :email, with: -> { _1.strip.downcase }

  def generate_confirmation_token
    signed_id expires_in: CONFIRMATION_TOKEN_EXP, purpose: :confirm_email
  end
end
