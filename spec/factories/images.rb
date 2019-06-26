FactoryBot.define do
  factory :image do
    comment { "hello!" }
    user_image {[Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/avatar_default.png'))]}
    user
  end
end