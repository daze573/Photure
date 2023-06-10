FactoryBot.define do
  factory :post_image do
    association :post
    image { Rack::Test::UploadedFile.new(Rails.root.join('app', 'assets', 'images', 'no_image.jpg'), 'image/jpeg') }
  end
end