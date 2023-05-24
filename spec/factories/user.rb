FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number:20) }
    email { "example@example.com" }
    password { "aaaaaa" }
    image { Rack::Test::UploadedFile.new(Rails.root.join('app', 'assets', 'images', 'no_image.jpg'), 'image/jpeg') }
  end
end