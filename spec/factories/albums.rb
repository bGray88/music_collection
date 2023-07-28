FactoryBot.define do
  factory :album do
    title { Faker::Music.album }
    release_year { Faker::Number.between(from: 1965, to: 2010) }
    genre { Faker::Music.genre }
    image { 'https://i.scdn.co/image/ab67616d00001e02ff9ca10b55ce82ae553c8228' }
  end
end
