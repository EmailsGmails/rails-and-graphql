# frozen_string_literal: true

module Mutations
  class CreateUserMutation < BaseMutation
    graphql_name 'createUser'

    argument :name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    field :user, Types::UserType, null: true
    field :errors, Types::ValidationErrorsType, null: true

    def resolve(args)
      user = User.new(args)

      if user.save
        confirmation_token = user.generate_confirmation_token
        UserMailer.confirmation(user, confirmation_token).deliver_now

        { user:, success: true }
      else
        { errors: user.errors, success: false }
      end
    end
  end
end
