# frozen_string_literal: true

class UserMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def confirmation(user, confirmation_token)
    @user = user
    @confirmation_token = confirmation_token

    mail to: @user.email, subject: 'Confirmation Instructions'
  end
end
