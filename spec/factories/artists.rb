FactoryBot.define do
  factory :artist do
    name { Faker::Music.band }
    image { 'https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228' }
    api_id { Faker::Number.between(from: 100000, to: 200000) }
  end
end
