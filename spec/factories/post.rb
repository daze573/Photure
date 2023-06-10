FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:20) }
    introduction { Faker::Lorem.characters(number:100) }
    user
    genre
    after(:create) do |post|
      create_list(:post_image, 1, post: post)
      create(:post_tag, post: post, tag: create(:tag))
    end
  end
end