# frozen_string_literal: true

module Queries
  class PostsByUserIdQuery < BaseQuery
    type [Types::PostType], null: false
    argument :user_id, ID, required: true

    def resolve(user_id:)
      User.find(user_id).posts
    end
  end
end
