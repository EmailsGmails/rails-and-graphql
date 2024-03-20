# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    password { SecureRandom.hex }

    after(:create) do |user|
      create_list(:post, 3, user:)
    end
  end
end
