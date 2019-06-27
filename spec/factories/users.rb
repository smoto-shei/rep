FactoryBot.define do
  factory :user do
    nickname { Faker::Pokemon.name }
    email { Faker::Internet.email }
    password { 123456 }
  end
end