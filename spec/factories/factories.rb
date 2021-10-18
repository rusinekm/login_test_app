# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    salt = BCrypt::Engine.generate_salt
    handle { Faker::Internet.unique.email }
    salt { salt }
    password { BCrypt::Engine.hash_secret('password', salt) }
  end
end
