FactoryBot.define do
  factory :user_body do
    weight { 60 }
    height { 160 }
    gender { '男' }
    birth_year { 1993 }
    avatar {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/avatar_default.png'))}
    experience {'2017-06-11'}
    user
  end
end
