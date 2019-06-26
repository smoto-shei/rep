require 'rails_helper'

RSpec.describe UserBody, type: :model do
  let(:dummy_image) {Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/dummy_image.rb'))}

  before do
    @user_body = FactoryBot.build(:user_body)
  end

  context "ユーザボディーが有効であるとき" do
    it "有効なユーザーボディーの検証" do
      expect(@user_body).to be_valid
    end

    context '身長' do
      it '身長が300cmの時' do
        @user_body.height = 300
        expect(@user_body).to be_valid
      end

      it '身長が100cmの時' do
        @user_body.height = 100
        expect(@user_body).to be_valid
      end
    end

    context '体重' do
      it '体重が20kgの時' do
        @user_body.weight = 20
        expect(@user_body).to be_valid
      end

      it '体重が350kgの時' do
        @user_body.weight = 350
        expect(@user_body).to be_valid
      end
    end

  end

  context 'ユーザーボディが無効であるとき' do

    context '身長' do
      it '301cm以上' do
        @user_body.height = 301
        expect(@user_body).not_to be_valid
      end

      it '50cm以下' do
        @user_body.height = 50
        expect(@user_body).not_to be_valid
      end
    end

    context '体重' do
      it '351kg以上' do
        @user_body.weight = 351
        expect(@user_body).not_to be_valid
      end

      it '10kg以下' do
        @user_body.weight = 10
        expect(@user_body).not_to be_valid
      end
    end

    context 'avatarの拡張子' do
      it 'avatar' do
        @user_body.avatar = dummy_image
        expect(@user_body).not_to be_valid
      end
    end

  end

end