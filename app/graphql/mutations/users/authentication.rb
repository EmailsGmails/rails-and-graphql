# frozen_string_literal: true

module Mutations
  module Users
    class Authentication < Mutations::BaseMutation
      graphql_name 'authentication'

      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::UserType, null: true
      field :token, String, null: true

      def resolve(email:, password:)
        user = User.find_by(email:)

        if User.authenticate_by(email:, password:)
          context[:current_user] = user
          token = AuthToken.token(user)

          { token:, user:, success: true }
        else
          context[:current_user] = nil

          raise GraphQL::ExecutionError, 'Incorrect Email/Password'
        end
      end
    end
  end
end
