require 'rails_helper'

describe 'ユーザーボディ', type: :system do
  describe 'ボディの表示' do
    before do
      user_a = FactoryBot.create(:user)
      FactoryBot.create(:user_body,user: user_a)

      visit new_user_session_path
      fill_in 'メールアドレス', with: 'test-5@com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
    end

    context 'test-5がログインしている時' do
      before do
      end

      it 'ユーザーボディ情報が表示されている' do
        # expect(page).to have_content 160
      end
    end
  end
end
