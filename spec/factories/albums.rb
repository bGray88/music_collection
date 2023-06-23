FactoryBot.define do
  factory :album do
    title { Faker::Music.album }
    release_year { Faker::Number.between(from: 1965, to: 2010) }
    genre { Faker::Music.genre }
  end
end
