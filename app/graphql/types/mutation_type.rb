# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUserMutation
    field :create_post, mutation: Mutations::CreatePostMutation
  end
end
