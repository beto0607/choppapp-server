FactoryBot.define do
  factory :vote do
    score { 1 }
    user { nil }
    beer { nil }
    description { "MyText" }
  end
end
