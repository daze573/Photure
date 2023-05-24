# frozen_string_literal: true

require 'rails_helper'

describe "作品投稿テスト" do
  before do
    load Rails.root.join("db/seeds.rb")
    @user = FactoryBot.create(:user)
    @genre = FactoryBot.create(:genre)
    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'ログイン'
    visit new_post_path
  end
  context "作品投稿フォームが存在しているか" do
    it "投稿用の画像フォームが表示されているか" do
      expect(page).to have_selector('.img_prev')
    end
    it "タイトル入力フォームが存在しているか" do
      expect(page).to have_field 'post[title]'
    end
    it "紹介文入力フォームが存在しているか" do
      expect(page).to have_field 'post[introduction]'
    end
    it "タグ入力フォームが存在しているか" do
      expect(page).to have_field 'post[tag]'
    end
    it "ジャンルセレクトフォームが存在しているか" do
      expect(page).to have_selector('#post_genre_id')
    end
  end
  context "作品の投稿が成功した場合" do
    it "情報を入力後投稿ボタンをクリックして遷移するか" do
      attach_file 'post[image]', Rails.root.join('app', 'assets', 'images', 'desk.jpg')
      fill_in 'post[title]', with: Faker::Lorem.characters(number:10)
      fill_in 'post[introduction]', with: Faker::Lorem.characters(number:20)
      tags = Faker::Lorem.words(number: 3)  # 3つの単語を生成
      fill_in 'post[tag]', with: tags.join('　')  # 単語をスペースで連結して入力
      find("#post_genre_id").find("option[value='1']").select_option
      click_button '投稿'
      expect(current_path).to eq root_path
    end
  end
  context "作品投稿が失敗した場合" do
    it "画像、作品名、紹介文を入力せず投稿ボタンをクリックした場合" do
      click_button '投稿'
      expect(current_path).to eq('/posts')
      expect(page).to have_content("画像を入力してください")
      expect(page).to have_content("タイトルを入力してください")
      expect(page).to have_content("紹介文を入力してください")
    end
  end
end