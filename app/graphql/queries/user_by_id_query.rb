# frozen_string_literal: true

module Queries
  class UserByIdQuery < BaseQuery
    type Types::UserType, null: true
    argument :id, ID, required: true

    def resolve(id:)
      User.find_by(id:)
    end
  end
end
