FactoryBot.define do
  factory :beer do
    name { "MyString" }
    alcohol { 1.5 }
    ibu { 1 }
    description { "MyText" }
    producer { nil }
  end
end
