# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    password = Faker::Lorem.characters(number: 8)
    name { Faker::Name.unique.first_name }
    email { Faker::Internet.unique.email }
    password { password }
    password_confirmation { password }
  end
end
