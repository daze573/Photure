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
      expect(page).to have_selector('.label')
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
    it "投稿ボタンが存在しているか" do
      expect(page).to have_button('投稿する')
    end
  end
  context "作品の投稿が成功した場合" do
    it "情報を入力後投稿ボタンをクリックして遷移するか" do
      attach_file 'post[post_images_attributes][0][image]', Rails.root.join('app', 'assets', 'images', 'desk.jpg')
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
      expect(page).to have_content("作品名を入力してください")
      expect(page).to have_content("作品紹介を入力してください")
    end
  end
end
describe "作品一覧画面（Topページ）テスト" do
  before do
    load Rails.root.join("db/seeds.rb")
    @user = FactoryBot.create(:user)
    @genre = FactoryBot.create(:genre)
    @tag = FactoryBot.create(:tag)
    @post = FactoryBot.create(:post, user: @user, genre: @genre, post_images: [FactoryBot.build(:post_image)])
    @post.tags << @tag
    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'ログイン'
    visit root_path
  end
  context "作品一覧画面（Topページ）の表示確認" do
    it "メインビジュアルが表示されている" do
      expect(page).to have_selector('.card-img')
    end
    it "ジャンル検索リストが表示されている" do
      expect(page).to have_link @genre.name
    end
    it "投稿された作品が表示されているか" do
      expect(page).to have_selector('.card-img-top')
    end

  end
end
describe "作品詳細画面テスト" do
  before do
    load Rails.root.join("db/seeds.rb")
    @user = FactoryBot.create(:user)
    @genre = FactoryBot.create(:genre)
    @tag = FactoryBot.create(:tag)
    @post = FactoryBot.create(:post, user: @user, genre: @genre, post_images: [FactoryBot.build(:post_image)])
    @post.tags << @tag
    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'ログイン'
    visit post_path(@post)
  end
  context "作品詳細画面の確認テスト" do
    it "会員のアイコンが表示されているか" do
      expect(page).to have_selector('.rounded-circle')
    end
    it "会員の名前が表示されているか" do
      expect(page).to have_content @post.user.name
    end
    it "投稿作品の画像が表示されているか" do
      expect(page).to have_selector('.post_image')
    end
    it "投稿ボタンが存在しているか" do
      expect(page).to have_link('投稿')
    end
    it "編集ボタンが存在しているか" do
      expect(page).to have_link('編集')
    end
    it "削除ボタンが存在しているか" do
      expect(page).to have_button('削除')
    end
    it "QRコード生成ボタンが存在しているか" do
      expect(page).to have_button('QRコード')
    end
    it "作品名が表示されているか" do
      expect(page).to have_content @post.title
    end
    it "作品の紹介文が表示されているか" do
      expect(page).to have_content @post.introduction
    end
    it "タグが表示されているか" do
      expect(page).to have_content @tag.name
    end
    it "作品のジャンルが表示されているか" do
      expect(page).to have_content @genre.name
    end
  end
  context "作品詳細画面の動作確認テスト" do
    it "投稿者名をクリックした時投稿者の詳細画面に遷移するか" do
      click_on @post.user.name
      expect(current_path).to eq user_information_path(@post.user)
    end
    it "アイコンをクリックした時投稿者の詳細画面に遷移するか" do
      find('.information').click
      expect(current_path).to eq user_information_path(@post.user)
    end
    it "投稿ボタンをクリックして作品投稿画面に遷移するか" do
      click_on '投稿'
      expect(current_path).to eq new_post_path
    end
    it "編集ボタンをクリックして作品編集画面に遷移するか" do
      click_on '編集'
      expect(current_path).to eq edit_post_path(@post)
    end
    it "削除ボタンをクリックして作品を削除できるか" do
      click_on '削除'
      expect(page).to have_selector('#deleteModal')
      click_on '削除する'
      expect(current_path).to eq root_path
      expect(@user.posts.reload).not_to include @post
    end
    it "QRコードボタンをクリックしてQRコードが表示されるか" do
      click_on 'QRコード'
      expect(page).to have_selector('#exampleModal')
    end
  end
end
describe "作品編集画面" do
  before do
    load Rails.root.join("db/seeds.rb")
    @user = FactoryBot.create(:user)
    @genre = FactoryBot.create(:genre)
    @tag = FactoryBot.create(:tag)
    @post = FactoryBot.create(:post, user: @user, genre: @genre, post_images: [FactoryBot.build(:post_image)])
    @post.tags << @tag
    visit new_user_session_path
    fill_in 'user[email]', with: @user.email
    fill_in 'user[password]', with: @user.password
    click_button 'ログイン'
    visit edit_post_path(@post)
  end
  context "作品編集画面確認テスト" do
    it "作品の画像が表示されているか" do
      expect(page).to have_selector('.img_prev')
    end
    it "作品名が入力フォームに入っているか" do
      expect(page).to have_field('post[title]')
      expect(find_field('post[title]').value).to eq(@post.title)
    end
    it "紹介文が入力フォームに入っているか" do
      expect(page).to have_field('post[introduction]')
      expect(find_field('post[introduction]').value).to eq(@post.introduction)
    end
    it "タグが入力フォームに入っているか" do
      expect(page).to have_field('post[tag]')
      expect(find_field('post[tag]').value).to include(@tag.name)
    end
    it "ジャンルが表示されているか" do
      expect(page).to have_selector('#post_genre_id')
    end
    it "更新ボタンが存在しているか" do
      expect(page).to have_button '更新'
    end
  end
  context "作品の更新確認テスト" do
    it "作品名を変えて更新ボタンをクリックした時内容が保存されて遷移するか" do
      fill_in 'post[title]', with: Faker::Lorem.characters(number:10)
      fill_in 'post[introduction]', with: @post.introduction
      fill_in 'post[tag]', with: @tag.name
      find("#post_genre_id").find("option[value='1']").select_option
      click_button '更新'
      expect(current_path).to eq post_path(@post)
    end
    it "作品名、紹介文が空白の時更新されずにバリデーションエラーが表示される" do
      fill_in 'post[title]', with: ' '
      fill_in 'post[introduction]', with: ' '
      fill_in 'post[tag]', with: @tag.name
      find("#post_genre_id").find("option[value='1']").select_option
      click_button '更新'
      expect(current_path).to eq post_path(@post)
      expect(page).to have_content '作品名を入力してください'
      expect(page).to have_content '作品紹介を入力してください'
    end
  end
end