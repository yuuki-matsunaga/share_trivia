FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number:10)}
    introduction { Faker::Lorem.characters(number:30)}
    genre
    user
  end
end