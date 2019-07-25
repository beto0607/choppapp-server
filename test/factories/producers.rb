FactoryBot.define do
  factory :producer do
    name { "MyString" }
    description { "MyText" }
    place { "MyString" }
    status { "MyString" }
    user
  end
end
