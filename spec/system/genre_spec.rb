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
end