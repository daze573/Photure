# frozen_string_literal: true

require 'rails_helper'

describe "ジャンル追加テスト" do
  before do
    load Rails.root.join("db/seeds.rb")
    @genre = FactoryBot.create(:genre)
    visit new_admin_session_path
    fill_in 'admin[email]', with: "admin@admin"
    fill_in 'admin[password]', with: "aaaaaa"
    click_button 'ログイン'
    visit admin_genres_path
  end
  context "ジャンル一覧画面の表示確認" do
    it "ジャンル追加フォーム" do
      expect(page).to have_field("genre[name]")
      expect(page).to have_button "button"
    end
    it "ジャンルテーブルのジャンル名" do
      expect(page).to have_content "写真"
      expect(page).to have_content "イラスト"
    end
    it "ジャンルテーブルの編集ボタン" do
      expect(page).to have_link("編集する")
    end
    it "追加したジャンルのジャンル名と編集ボタン" do
      expect(page).to have_content @genre.name
      expect(page).to have_link("編集する")
    end
  end
  context "ジャンル一覧画面の動作確認" do
    it "ジャンルを追加できるか" do
      fill_in "genre[name]", with: Faker::Lorem.word
      click_button(class: "genre_button")
      expect(page).to have_content @genre.name
    end
    it "編集ボタンを押してジャンル編集画面に遷移するか" do
      find("#genre_1").click
      expect(current_path).to eq edit_admin_genre_path(1)
    end
  end
end
describe "ジャンル編集テスト" do
  before do
    load Rails.root.join("db/seeds.rb")
    @genre = FactoryBot.create(:genre)
    visit new_admin_session_path
    fill_in 'admin[email]', with: "admin@admin"
    fill_in 'admin[password]', with: "aaaaaa"
    click_button 'ログイン'
    visit edit_admin_genre_path(1)
  end
  context "ジャンル編集画面の表示確認" do
    it "ジャンル名の表示" do
      expect(page).to have_content "写真"
    end
    it "ジャンル名の更新用のフォームの表示" do
      expect(page).to have_field "genre[name]"
    end
    it "更新ボタンの表示" do
      expect(page).to have_button "更新"
    end
  end
  context "ジャンル編集画面の動作確認" do
    it "更新ボタンをクリックしてジャンル一覧画面に遷移するか" do
      fill_in "genre[name]", with: "しゃしん"
      click_button "更新"
      expect(current_path).to eq admin_genres_path
      expect(page).to have_content "しゃしん"
    end
  end
end