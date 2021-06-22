# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    password = Faker::Lorem.characters(number: 8)
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
  end
end
