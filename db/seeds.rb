# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: "admin@admin",
  password: "aaaaaa"
)
User.create!(
  name: "山田",
  image: File.open("./app/assets/images/no_image.jpg"),
  email: "test@test.com",
  password: "aaaaaa",
  introduction: "よろしくお願いします！",
  user_status: false
)
Genre.create!(
  name: "写真"
)
Post.create!(
  user_id: 1,
  genre_id: 1,
  title: "デスクトップ",
  introduction: "デスクトップのイメージ写真",
  image: File.open("./app/assets/images/desk.jpg"),
  status: 1
)
Favorite.create!(
  user_id: 1,
  post_id: 1
)
Comment.create!(
  user_id: 1,
  post_id: 1,
  comment: "ありがとうございます"
)
Tag.create!(
  name: "エンジニア"
)
PostTag.create!(
  post_id: 1,
  tag_id: 1
)