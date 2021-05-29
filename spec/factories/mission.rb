# frozen_string_literal: true

FactoryBot.define do
  factory :mission do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    started_at { DateTime.now }
    ended_at { DateTime.now + 1 }
  end
end
