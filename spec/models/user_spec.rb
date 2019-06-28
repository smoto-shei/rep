
require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.create(:user)
  end

  context "ユーザーが有効" do
    it "有効なユーザーの検証" do
      expect(@user).to be_valid
    end

    it "メールアドレスの小文字変換" do
      @user.email = "TEst@ExAMPle.com"
      @user.save!
      expect(@user.reload.email).to eq "test@example.com"
    end

  end

  context "ユーザーが無効" do

    it "ニックネームがnil" do
      @user.nickname = nil
      expect(@user).not_to be_valid
    end

    it "ニックネームが20文字を超過" do
      @user.nickname = "a"*21
      expect(@user).not_to be_valid
    end

    it "メールアドレスがnil" do
      @user.email = nil
      expect(@user).not_to be_valid
    end

    it "メールアドレスの一意性" do
      user = FactoryBot.build(:user, email: "#{@user.email}")
      expect(user).not_to be_valid
    end

    it "パスワードがnil" do
      @user.password = @user.password_confirmation = ""
      binding.pry
      expect(@user).not_to be_valid
    end

    it "パスワードが6文字未満" do
      @user.password = @user.password_confirmation = "a"*5
      expect(@user).not_to be_valid
    end

  end
end