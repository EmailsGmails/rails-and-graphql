# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { FFaker::Lorem.sentence }
    content { FFaker::Lorem.paragraph }
    user { association :user }
  end
end
