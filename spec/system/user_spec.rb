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
end