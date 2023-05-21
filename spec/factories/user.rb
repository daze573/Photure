FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number:20) }
    email { "example@example.com" }
    password { "aaaaaa" }
  end
end