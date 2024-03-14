module Queries
  class AllUsersQuery < BaseQuery
    type [Types::UserType], null: false

    def resolve
      User.all
    end
  end
end
