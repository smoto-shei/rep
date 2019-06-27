FactoryBot.define do
  factory :training_record do
    part { '胸' }
    date { '2018-06-26' }
    exercise { 'ベンチプレス' }
    user
  end
end
