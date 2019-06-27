FactoryBot.define do
  factory :user do
    nickname { Faker::Games::Pokemon.name }
    email { Faker::Internet.email }
    password { 123456 }
  end
end