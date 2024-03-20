# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, { null: true }], null: true,
                                                     description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    field :who_am_i, String, null: false,
                             description: 'Who am I'
    def who_am_i
      "You've authenticated as #{context[:current_user]&.email || 'guest'}."
    end

    field :users, resolver: Queries::AllUsersQuery
    field :user, resolver: Queries::UserByIdQuery
    field :posts_by_user, resolver: Queries::PostsByUserIdQuery
  end
end
