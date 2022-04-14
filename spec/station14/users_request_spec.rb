require 'rails_helper'

# ユーザー登録周りのテスト
RSpec.describe User, type: :request do
    let(:user) { create(:user) }
    let(:user_params) { attributes_for(:user) }
    let(:invalid_no_name_user_params) { attributes_for(:user, name: "") }
    let(:invalid_no_email_user_params) { attributes_for(:user, email: "") }
    let(:invalid_no_password_user_params) { attributes_for(:user, password: "") }
    let(:invalid_no_password_confirmation_user_params) { attributes_for(:user, password_confirmation: "") }

    describe 'Staton14 POST /users' do
        it '名前・メールアドレス・パスワード・確認用パスワードが全て入力されていて、ユーザー登録ができること' do
            post user_registration_path, params: { user: user_params }
            expect(response.status).to eq 302
        end

        it '名前が入力されていないときはユーザー登録ができないこと' do
            post user_registration_path, params: { user: invalid_no_name_user_params }
        end.to_not change(User, :count)

        it 'メールアドレスが入力されていないときはユーザー登録ができないこと' do
            post user_registration_path, params: { user: invalid_no_email_user_params }
        end.to_not change(User, :count)

        it 'パスワードが入力されていないときはユーザー登録ができないこと' do
            post user_registration_path, params: { user: invalid_no_password_user_params }
        end.to_not change(User, :count)

        it '確認用パスワードが入力されていないときはユーザー登録ができないこと' do
            post user_registration_path, params: { user: invalid_no_password_confirmation_user_params }
        end.to_not change(User, :count)

        it 'パスワードと確認用パスワードが一致しないときはユーザー登録ができないこと' do
            post user_registration_path, params: { user: attributes_for(:user, password: "testuser", password_confirmation: "testuser2") }
        end.to_not change(User, :count)
    end
end
