# frozen_string_literal: true

module Mutations
  module Posts
    class CreatePost < Mutations::BaseMutation
      graphql_name 'createPost'

      argument :title, String, required: true
      argument :content, String, required: true

      field :post, Types::PostType, null: true
      field :errors, Types::ValidationErrorsType, null: true

      def resolve(title:, content:)
        current_user = context[:current_user]
        raise GraphQL::ExecutionError, 'Authentication required' unless current_user

        post = current_user.posts.build(title:, content:)
        if post.save
          { post:, success: true }
        else
          { post: nil, errors: post.errors, success: false }
        end
      end
    end
  end
end
