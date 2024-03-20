# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '#authentication mutation' do
  before do
    @password = SecureRandom.hex
    @user = FactoryBot.create(:user, email: 'user@example.com', password: @password)
  end

  let(:mutation) do
    <<~GQL
      mutation authentication($email: String!, $password: String!) {
        authentication(input: {
          email: $email
          password: $password
        }) {
          user {
            id
            email
            name
          }
          token
        }
      }
    GQL
  end

  it 'is successful with correct email and password' do
    result = RailsAndGraphqlSchema.execute(mutation, variables: {
                                             email: 'user@example.com',
                                             password: @password
                                           })

    expect(result.dig('data', 'authentication', 'errors')).to be_nil
    expect(result.dig('data', 'authentication', 'user', 'email')).to eq('user@example.com')
    expect(result.dig('data', 'authentication', 'user', 'id')).to be_present
    expect(result.dig('data', 'authentication', 'token')).to be_present
  end

  it 'fails with wrong password' do
    result = RailsAndGraphqlSchema.execute(mutation, variables: {
                                             email: 'user@example.com',
                                             password: 'wrong-password'
                                           })

    expect(result.dig('data', 'authentication', 'user', 'id')).to be_nil
    expect(result.dig('data', 'authentication', 'token')).to be_nil
    expect(result.dig('errors', 0, 'message')).to eq('Incorrect Email/Password')
  end
end
