FactoryBot.define do
  factory :vote do
    score { 5 }
    description { "MyText" }
    user
    beer
  end
end
