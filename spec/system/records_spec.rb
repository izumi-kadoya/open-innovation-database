require 'rails_helper'

RSpec.describe 'CSVアップロード', type: :system do
  before do
    @user = FactoryBot.create(:user, admin: 1)
    @csv_file_path = Rails.root.join('spec', 'fixtures', 'sample.csv')  # spec/fixturesディレクトリにsample.csvというサンプルCSVがあると仮定
  end

  context 'CSVアップロードができるとき' do
    it 'ログインした管理者ユーザーはCSVをアップロードできる' do
      # ログインする
      sign_in(@user)

      # ログイン成功を確認する
      expect(page).to have_content('Log out')

      # CSVアップロードページに移動する
      visit new_record_path

      # CSVファイルをアップロードする
      attach_file('record[csv]', @csv_file_path)
      click_on 'Upload'

      # DBの変更を確認する
      expect(Record.count).to eq(1)
    end
  end

  context 'CSVアップロードができないとき' do
    it 'ログインしていないユーザーはアップロードページにアクセスできない' do
      visit new_record_path
      # トップページにリダイレクトされる
      expect(current_path).to eq root_path
    end

    it '管理者でないユーザーはアップロードページにアクセスできない' do
      # 管理者でないユーザーとしてログイン
      non_admin_user = FactoryBot.create(:user, admin: 0)
      # ログインする
      sign_in(non_admin_user)
      # CSVアップロードページにアクセスを試みる
      visit new_record_path
      # トップページにリダイレクトされる
      expect(current_path).to eq root_path
    end
  end
end
