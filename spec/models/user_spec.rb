
require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.create(:user)
  end

  context "ユーザーが有効であるとき" do
    it "有効なユーザーの検証" do
      expect(@user).to be_valid
    end

    it "メールアドレスの小文字変換" do
      @user.email = "TEst@ExAMPle.com"
      @user.save!
      expect(@user.reload.email).to eq "test@example.com"
    end

  end

  context "ユーザーが無効であるとき" do
    it "名前の存在性" do
      @user.nickname = ""
      expect(@user).not_to be_valid
    end

    it "ユーザー名の長さ" do
      @user.nickname = "a"*51
      expect(@user).not_to be_valid
    end

    it "メールアドレスの存在性" do
      @user.email = ""
      expect(@user).not_to be_valid
    end

    it "メールアドレスの一意性" do
      user = FactoryBot.build(:user, email: "test@example.com")
      expect(user).not_to be_valid
    end

    it "パスワードの存在性" do
      @user.password = @user.password_confirmation = ""
      expect(@user).not_to be_valid
    end

    it "パスワードの最小長さ" do
      @user.password = @user.password_confirmation = "a"*5
      expect(@user).not_to be_valid
    end

  end
end