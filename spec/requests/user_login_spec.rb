require 'rails_helper'

describe 'ログイン処理', type: :request do
  let!(:user) { FactoryBot.create(:user, password: 'password', confirmed_at: Time.now) }

  describe '管理者がログインできることを確認' do
    it do
      get new_user_session_path
      expect(response).to have_http_status(:success)
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to 'http://www.example.com/users/dash_boards'
    end
  end

  # 上記コードを参考に作成
  let!(:user1) { FactoryBot.create(:user, email:'test_user1@gmail.com', password: 'password', confirmed_at: Time.now) }
  describe '一般ユーザーでログインできることを確認' do
    it do
      get new_user_session_path
      expect(response).to have_http_status(:success)
      post user_session_path, params: { user: { email: user1.email, password: user1.password } }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to 'http://www.example.com/users/dash_boards'
    end
  end

  # 速習実践テキストを参考に作成
  let!(:user2) { FactoryBot.create(:user, email:'test_user2@gmail.com', password: 'password', confirmed_at: Time.now) }
  context '一般ユーザーでログインできることを確認' do
    before do
      visit  new_user_session_path
      fill_in 'email', with: user2.email
      fill_in 'password', with: user2.password
      click_button 'ログイン'
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to 'http://www.example.com/users/dash_boards'
    end
  end
end

# describe do を作り直して、let!(:user) を指定すると、後述のemailでテスト通る。 
describe 'ログイン処理', type: :request do
  let!(:user) { FactoryBot.create(:user, email:'test_user1@gmail.com', password: 'password', confirmed_at: Time.now) }
  describe '一般ユーザーでログインできることを確認' do
    it do
      get new_user_session_path
      expect(response).to have_http_status(:success)
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to 'http://www.example.com/users/dash_boards'
      #expect(response).to have_content 'ログインしました。'
      #expect(page).to have_content 'ログインしました。'
      #expect(response.body).to include 'ログインしました。'
    end
  end
end

#

