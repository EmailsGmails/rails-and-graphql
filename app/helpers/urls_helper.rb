# frozen_string_literal: true

module UrlsHelper
  def confirmation_url(token) = "#{ENV['BASE_URL'] || 'http://localhost:3000'}/users/confirm/#{token}"

  def confirmation_path(token) = "/users/confirm/#{token}"
end
