# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { SecureRandom.hex }
    name { FFaker::Name.name }

    after(:create) do |user|
      create_list(:post, 3, user:)
    end
  end
end
