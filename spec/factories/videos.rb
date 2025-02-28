FactoryBot.define do
  factory :video do
    title { Faker::Movie.title }
    url { "https://www.youtube.com/watch?v=#{Faker::Alphanumeric.alphanumeric(number: 10)}" }
    association :user
  end
end