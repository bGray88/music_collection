FactoryBot.define do
  factory :artist do
    name { Faker::Music.band }
    form_year { Faker::Number.between(from: 1965, to: 2010) }
  end
end
