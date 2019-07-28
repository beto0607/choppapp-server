FactoryBot.define do
  factory :beer_type do
    sequence :name do |n|
      "Beer type ##{n}"
    end
    description { "MyText" }
  end
end
