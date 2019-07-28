FactoryBot.define do
  factory :beer do
    sequence :name do |n|
      "beer ##{n}"
    end
    alcohol { 1.5 }
    ibu { 1 }
    description { "MyText" }
    status { "ACTIVE" }
    producer
    beer_type
  end
end
