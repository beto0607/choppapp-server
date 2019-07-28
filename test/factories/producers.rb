FactoryBot.define do
  factory :producer do
    sequence :name do |n|
      "producer ##{n}"
    end
    description { "MyText" }
    place { "MyString" }
    status { "PENDING" }
    user
  end
end
