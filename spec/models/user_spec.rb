# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it "会員の新規登録が保存されるか" do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  it "名前、メール、パスワードが空白で登録が保存されずにエラーメッセージが出るか" do
    user = User.new(
      name: nil,
      email: nil,
      password: nil
    )
    expect(user).to be_invalid
    expect(user.errors[:name]).to include("を入力してください")
    expect(user.errors[:email]).to include("を入力してください")
    expect(user.errors[:password]).to include("を入力してください")
  end
end