FactoryBot.define do
  factory :user_body do
    weight { rand(20..350) }
    height { rand(100..300) }
    gender { ['男','女'].sample }
    birth_year { rand(1900..Date.today.year) }
    avatar {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/avatar_default.png'))}
    experience {Date.today}
    user
  end
end
