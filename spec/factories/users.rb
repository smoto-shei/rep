FactoryBot.define do
  factory :user do
    nickname { 'test-5'}
    email { 'test@example.com' }
    password { 123456 }
  end
end