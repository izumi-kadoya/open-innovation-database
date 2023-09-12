require 'rails_helper'

RSpec.describe 'UserSignUp', type: :system do
  before do
    basic_auth_pass_through
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('Sign up')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'Nickname', with: @user.nickname
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      fill_in 'Password confirmation', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
        sleep 1
      }.to change { User.count }.by(1)
      # トップページへ遷移することを確認する
      expect(page).to have_current_path(root_path)
      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(
        find('.user_nav').find('span').hover
      ).to have_content('Log out')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('Sign up')
      expect(page).to have_no_content('Log in')
    end
  end
  
  it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
    # トップページに移動する
    visit root_path
    # トップページにサインアップページへ遷移するボタンがあることを確認する
    expect(page).to have_content('Sign up')
    # 新規登録ページへ移動する
    visit new_user_registration_path
    # ユーザー情報を入力する
    fill_in 'Nickname', with: ''
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''
    # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
    expect{
      find('input[name="commit"]').click
      sleep 1
    }.to change { User.count }.by(0)
    # 新規登録ページへ戻されることを確認する
    expect(page).to have_current_path(new_user_registration_path)
  end
end


RSpec.describe 'Log in', type: :system do
  before do
    basic_auth_pass_through
    @user = FactoryBot.create(:user)
  end
  context 'ログインができるとき' do
  it '保存されているユーザーの情報と合致すればログインができる' do
    # トップページに移動する
    visit root_path
    # トップページにログインページへ遷移するボタンがあることを確認する
    expect(page).to have_content('Log in')
    # ログインページへ遷移する
    visit new_user_session_path
    # 正しいユーザー情報を入力する
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    # ログインボタンを押す
    find('input[name="commit"]').click
    # トップページへ遷移することを確認する
    expect(page).to have_current_path(root_path)
    # カーソルを合わせるとログアウトボタンが表示されることを確認する
    expect(
      find('.user_nav').find('span').hover
    ).to have_content('ログアウト')
    # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
    expect(page).to have_no_content('Sign up')
    expect(page).to have_no_content('Log in')
  end
 end
  context 'ログインができないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動する
       visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
       expect(page).to have_content('Log in')
      # ログインページへ遷移する
       visit new_user_session_path
      # ユーザー情報を入力する
       fill_in 'Email', with: ''
       fill_in 'Password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(page).to have_current_path(new_user_session_path)
    end
  end


end

private
def basic_auth_pass_through
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  if page.driver.browser.respond_to?(:authorize)
    page.driver.browser.authorize(username, password)
  else
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{current_path}"
  end
end