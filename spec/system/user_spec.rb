# frozen_string_literal: true

require 'rails_helper'

describe "会員の新規登録テスト" do
  before do
    visit new_user_registration_path
  end
  context "フォームの確認テスト" do
    it "名前の入力フォームが存在するか" do
      expect(page).to have_field('user[name]')
    end
    it "メールの入力フォームが存在するか" do
      expect(page).to have_field('user[email]')
    end
    it "パスワードの入力フォームが存在するか" do
      expect(page).to have_field('user[password]')
    end
    it "登録ボタンが存在するか" do
      expect(page).to have_button('commit')
    end
  end
  context "新規登録テスト" do
    it "ユーザーの情報を登録する" do
      fill_in 'user[name]', with: Faker::Lorem.characters(number:10)
      fill_in 'user[email]', with: "example@example.com"
      fill_in 'user[password]', with: "aaaaaa"
      fill_in 'user[password_confirmation]', with: "aaaaaa"
      click_button "登録"
      expect(current_path).to eq root_path
    end
    it "ユーザーの登録に失敗する" do
      fill_in 'user[name]', with: ' '
      fill_in 'user[email]', with: ' '
      fill_in 'user[password]', with: ' '
      fill_in 'user[password_confirmation]', with: ' '
      click_button "登録"
      expect(current_path).to eq('/users')
    end
  end
end

describe "ログインテスト" do
  before do
    visit new_user_session_path
  end
  context "ログインフォームの確認" do
    it "メールの入力フォームが存在するか" do
      expect(page).to have_field('user[email]')
    end
    it "パスワードの入力フォームが存在するか" do
      expect(page).to have_field('user[password]')
    end
    it "ログインボタンが存在するか" do
      expect(page).to have_button('commit')
    end
  end

  context "ログインできるかの確認" do
    before do
      @user = FactoryBot.create(:user)
    end
    it "保存されているユーザーと一致すればログインできる" do
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_button 'ログイン'
      expect(current_path).to eq root_path
    end
  end
  it "保存されているユーザーと一致しない場合ログインできない" do
    fill_in 'user[email]', with: ' '
    fill_in 'user[password]', with: ' '
    click_button 'ログイン'
    expect(current_path).to eq new_user_session_path
  end
end

describe "ユーザーの詳細画面" do
  before do
    @user = FactoryBot.create(:user)
    @posts = FactoryBot.create_list(:post, 12, user: @user, genre: FactoryBot.create(:genre), post_images: [FactoryBot.build(:post_image)])
    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'ログイン'
    visit user_information_path(@user)
  end
  context "ユーザー詳細画面の表示確認" do
    it "アイコン画像が表示されているか" do
      expect(page).to have_selector('.icon')
    end
    it "ユーザー名が表示されているか" do
      expect(page).to have_content @user.name
    end
    it "投稿ボタンが存在しているか" do
      expect(page).to have_link "投稿"
    end
    it "編集ボタンが存在しているか" do
      expect(page).to have_link "編集"
    end
    it "退会ボタンが存在しているか" do
      expect(page).to have_link "退会"
    end
    it "いいね一覧が存在しているか" do
      expect(page).to have_link "いいね一覧"
    end
    it "ユーザーの投稿作品一覧が存在しているか" do
      @posts.each do |post|
        expect(page).to have_link(href: post_path(post))
      end
    end
  end
  context "詳細画面の遷移の確認" do
    it "投稿ボタンをクリックする" do
      click_on "投稿"
      expect(current_path).to eq new_post_path
    end
    it "編集ボタンをクリックする" do
      click_on "編集"
      expect(current_path).to eq("/users/" + @user.id.to_s + "/information/" + "edit")
    end
    it "退会ボタンをクリックする" do
      click_on "退会"
      expect(current_path).to eq("/users/" + @user.id.to_s + "/withdraw")
    end
    it "いいね一覧ボタンをクリックする" do
      click_on "いいね一覧"
      expect(current_path).to eq("/users/" + @user.id.to_s + "/favorites")
    end
  end
  context "投稿作品一覧の遷移の確認" do
    it "投稿作品をクリックしたらその作品の詳細画面に遷移する" do
      page.all('.test')[11].click
      expect(current_path).to eq("/posts/" + @posts.first.id.to_s)
    end
  end
end

describe "ユーザー編集画面" do
  before do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'ログイン'
    visit edit_user_information_path(@user)
  end
  context "ユーザー編集画面に情報入力フォームが存在しているか" do
    it "アカウント名の更新用入力フォームが存在しているか" do
      expect(find_field('user[name]').value).to eq(@user.name)
    end
    it "プロフィールの更新用入力フォームが存在しているか" do
      expect(page).to have_field('user[introduction]')
    end
    it "アイコン画像が表示されているか" do
      expect(page).to have_selector('.img_prev')
    end
    it "更新ボタンが表示されているか" do
      expect(page).to have_button('更新')
    end
  end
  context "更新が保存され遷移するか" do
    it "必要な情報を入力して更新ボタンをクリックする" do
      fill_in 'user[name]', with: Faker::Lorem.characters(number:10)
      fill_in 'user[introduction]', with: Faker::Lorem.characters(number:20)
      attach_file('user[image]', Rails.root.join('app', 'assets', 'images', 'art.jpg'))
      click_button '更新'
      expect(current_path).to eq('/users/' + @user.id.to_s + '/information')
    end
  end
  context "更新が失敗した時の処理" do
    it "名前の入力フォームが空の場合" do
      fill_in 'user[name]', with: nil
      fill_in 'user[introduction]', with: Faker::Lorem.characters(number:20)
      attach_file('user[image]', Rails.root.join('app', 'assets', 'images', 'art.jpg'))
      click_button '更新'
      expect(current_path).to eq('/users/' + @user.id.to_s + '/information')
      have_content "名前を入力してください"
    end
  end
end