# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  it "有効な保存内容の場合は保存されるか" do
    user = FactoryBot.create(:user)  # Userオブジェクトを作成
    genre = FactoryBot.create(:genre)  # Genreオブジェクトを作成

    image_path = Rails.root.join('app', 'assets', 'images', 'no_image.jpg')
    post = Post.new(
      title: "タイトル",
      introduction: "説明文",
      image: fixture_file_upload(image_path, 'image/jpeg'),  # 画像のアップロード
      user: user,  # userオブジェクトを関連付け
      genre: genre  # genreオブジェクトを関連付け
    )

    expect(post).to be_valid
    expect(post.save).to be_truthy  # 戻り値をtrueで返すマッチャー
    expect(Post.count).to eq(1)
  end

  it "タイトルがない場合は保存されないか" do
    user = FactoryBot.create(:user)
    genre = FactoryBot.create(:genre)

    image_path = Rails.root.join('app', 'assets', 'images', 'no_image.jpg')
    post = Post.new(
      title: nil,
      introduction: "説明文",
      image: fixture_file_upload(image_path, 'image/jpeg'),
      user: user,
      genre: genre
    )

    expect(post).not_to be_valid
    expect(post.errors[:title]).to include("を入力してください")
  end

end
