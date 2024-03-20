# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::Posts::CreatePost, type: :request do
  let(:mutation) do
    <<~GQL
      mutation createPost($title: String!, $content: String!) {
        createPost(input: {
          title: $title
          content: $content
        }) {
          post {
            title
            content
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

  context 'user is authenticated' do
    it 'creates a new post' do
      title = FFaker::Lorem.sentence
      content = FFaker::Lorem.paragraph
      user = FactoryBot.create(:user, password: 'password123')

      post '/graphql', params: { query: mutation, variables: { title:, content: } },
                       headers: { 'Authorization' => AuthToken.token(user).to_s }
      result = JSON.parse(response.body)

      expect(result.dig('data', 'createPost', 'post', 'title')).to eq(title)
      expect(result.dig('data', 'createPost', 'post', 'content')).to eq(content)
      expect(result.dig('data', 'createPost', 'success')).to eq(true)
      expect(result.dig('data', 'createPost', 'errors')).to be_nil
    end
  end

  context 'user is not authenticated' do
    it 'does not create a new post' do
      title = FFaker::Lorem.sentence
      content = FFaker::Lorem.paragraph
      post '/graphql', params: { query: mutation, variables: { title:, content: } },
                       headers: { 'Authorization' => 'wrong-token' }
      result = JSON.parse(response.body)

      expect(result.dig('data', 'createPost', 'post')).to be_nil
      expect(result['errors'].any? { |error| error['message'].include?('Authentication required') }).to eq(true)
    end
  end
end
