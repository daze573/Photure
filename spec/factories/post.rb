FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:20) }
    introduction { Faker::Lorem.characters(number:100) }
    image { Rack::Test::UploadedFile.new(Rails.root.join('app', 'assets', 'images', 'no_image.jpg'), 'image/jpeg') }
    user
    genre
    after(:create) do |post|
      create(:post_tag, post: post, tag: create(:tag))
    end
  end
end