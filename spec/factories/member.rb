# frozen_string_literal: true

FactoryBot.define do
    factory :member do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      password { '123456' }
      password_confirmation { '123456' }
    end
  end