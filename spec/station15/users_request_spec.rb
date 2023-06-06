require 'rails_helper'

# ユーザー登録周りのテスト
RSpec.describe User, type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:attributes) { %w[name email password password_confirmation] }

describe 'Staton14 POST /users' do
    it '必須項目（名前、メールアドレス、パスワード、確認用パスワード）が全て入力されていて、ユーザー登録ができること' do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq 302
    end

    it '必須項目が空文字のときにはユーザー登録ができないこと' do
        attributes.each do |attr|
            params = user_params.dup
            params[attr.to_sym] = ""
            expect do
                post user_registration_path, params: { user: params }
            end.to_not change(User, :count)
        end
    end

    it '必須項目がnullのときにはユーザー登録ができないこと' do
        attributes.each do |attr|
            params = user_params.dup
            params[attr.to_sym] = nil
            expect do
                post user_registration_path, params: { user: params }
            end.to_not change(User, :count)
        end
    end

    it '必須項目が欠けている時にはユーザー登録ができないこと' do
        attributes.each do |attr|
            params = user_params.dup
            params.delete(attr.to_sym)
            expect do
                post user_registration_path, params: { user: params }
            end.to_not change(User, :count)
        end
    end

    it 'パスワードと確認用パスワードが一致しないときはユーザー登録ができないこと' do
      expect do
        post user_registration_path, params: { user: attributes_for(:user, password: "testuser", password_confirmation: "testuser2") }
      end.to_not change(User, :count)
    end
  end
end
