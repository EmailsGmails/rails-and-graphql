# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::Users::CreateUser
    field :authentication, mutation: Mutations::Users::Authentication
    field :create_post, mutation: Mutations::Posts::CreatePost
  end
end
