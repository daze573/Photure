# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Genre, type: :model do
  it "登録した内容は保存されるのか" do
    genre = FactoryBot.create(:genre)
    expect(genre).to be_valid
  end

  it "ジャンル名が存在せず保存されないか" do
    genre = Genre.new(
      name: nil
    )

    expect(genre).to be_invalid
    expect(genre.errors[:name]).to include("を入力してください")
  end
end