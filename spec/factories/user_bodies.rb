FactoryBot.define do
  factory :user_body do
    weight { 60 }
    height { 160 }
    gender { '男' }
    birth_year { 1993 }
    avatar { 'no_avatar.png'}
    # experience { 2014-06-01}
    user
  end
end
