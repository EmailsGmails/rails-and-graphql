# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '#createUser mutation' do
  let(:mutation) do
    <<~GQL
        mutation createUser($name: String!, $email: String!, $password: String!) {
          createUser(input: {
            name: $name
            email: $email
            password: $password
          }) {
          user {
            id
            email
            name
          }
          success
          errors {
            details
            fullMessages
          }
        }
      }
    GQL
  end

  it 'is successful with correct data' do
    name = FFaker::Name.name
    email = FFaker::Internet.email
    result = RailsAndGraphqlSchema.execute(mutation, variables: {
                                             name:,
                                             email:,
                                             password: SecureRandom.hex
                                           })

    expect(result.dig('data', 'createUser', 'user', 'email')).to eq(email)
    expect(result.dig('data', 'createUser', 'user', 'name')).to eq(name)
    expect(result.dig('data', 'createUser', 'success')).to eq(true)
    expect(result.dig('data', 'createUser', 'errors')).to be_nil
  end

  it 'fails in case of wrong email format' do
    wrong_email = 'test.user'
    result = RailsAndGraphqlSchema.execute(mutation, variables: {
                                             name: FFaker::Name.name,
                                             email: wrong_email,
                                             password: SecureRandom.hex
                                           })

    expect(result.dig('data', 'createUser', 'user')).to be_nil
    expect(result.dig('data', 'createUser', 'success')).to eq(false)
    expect(result.dig('data', 'createUser', 'errors',
                      'details')).to eq("{\"email\":[{\"error\":\"invalid\",\"value\":\"#{wrong_email}\"}]}")
    expect(result.dig('data', 'createUser', 'errors', 'fullMessages')).to include('Email is invalid')
  end

  it 'fails in case of no password' do
    result = RailsAndGraphqlSchema.execute(mutation, variables: {
                                             name: FFaker::Name.name,
                                             email: FFaker::Internet.email,
                                             password: ""
                                           })

    expect(result.dig('data', 'createUser', 'user')).to be_nil
    expect(result.dig('data', 'createUser', 'success')).to eq(false)
    expect(result.dig('data', 'createUser', 'errors',
                      'details')).to eq('{"password":[{"error":"blank"},{"error":"too_short","count":8}]}')
    expect(result.dig('data', 'createUser', 'errors', 'fullMessages')).to include("Password can't be blank")
    expect(result.dig('data', 'createUser', 'errors',
                      'fullMessages')).to include('Password is too short (minimum is 8 characters)')
  end
end
