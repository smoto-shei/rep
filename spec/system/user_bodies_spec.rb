require 'rails_helper'

describe 'ユーザーボディ', type: :system do
  describe 'ログイン' do
    before do
      @user = FactoryBot.create(:user)
      @userbody = FactoryBot.create(:user_body,user: @user)

      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      click_button 'ログイン'
    end

    it 'ログインの成功' do
      expect(page).to have_content 'ログインしました'
    end

    it 'リダイレクト先がカレンダーページ' do
      show_url = "/users/#{@user.id}"
      expect(current_path).to eq show_url
    end


    context 'カレンダーページ' do

      it 'ユーザーボディ情報が表示されている' do
        expect(page).to have_content "#{@userbody.height}" &&
      end
    end
  end
end
