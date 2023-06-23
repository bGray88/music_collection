FactoryBot.define do
  factory :song do
    title { Faker::Music::RockBand.song }
    create_year { Faker::Number.between(from: 1965, to: 2010) }
    length { Faker::Number.between(from: 0.5, to: 10.5) }
  end
end
