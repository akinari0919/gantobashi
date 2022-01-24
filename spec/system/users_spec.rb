require 'rails_helper'

RSpec.describe User, type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'User CRUD' do
    describe 'ログイン前' do
      describe 'ユーザー新規登録' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの新規作成が成功すること' do
            visit new_user_path
            fill_in 'Name', with: 'test'
            fill_in 'Email', with: 'test@example.com'
            fill_in 'Password', with: 'password'
            fill_in 'Password confirmation', with: 'password'
            click_button 'SignUp'
            expect(current_path).to eq login_path
          end
        end
        context 'メールアドレス未記入' do
          it 'ユーザーの新規作成が失敗すること' do
            visit new_user_path
            fill_in 'Name', with: 'test'
            fill_in 'Email', with: nil
            fill_in 'Password', with: 'password'
            fill_in 'Password confirmation', with: 'password'
            click_button 'SignUp'
            expect(current_path).to eq users_path
          end
        end
        context '登録済メールアドレス' do
          it 'ユーザーの新規作成が失敗すること' do
            visit new_user_path
            fill_in 'Name', with: 'test'
            fill_in 'Email', with: user.email
            fill_in 'Password', with: 'password'
            fill_in 'Password confirmation', with: 'password'
            click_button 'SignUp'
            expect(current_path).to eq users_path
          end
        end
      end
    end
  end
end
