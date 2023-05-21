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
    before do
      visit new_user_registration_path
    end
    it "名前を入力する" do
      fill_in 'user[name]', with: Faker::Lorem.characters(number:10)
      fill_in 'user[email]', with: "example@example.com"
      fill_in 'user[password]', with: "aaaaaa"
      fill_in 'user[password_confirmation]', with: "aaaaaa"
      click_button "登録"
      expect(current_path).to eq root_path
    end
  end
end