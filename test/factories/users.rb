FactoryBot.define do
  factory :user do
    sequence :username do |n|
      "username#{n}"
    end
    email { "#{username}@example.com" }
    password_digest { "MyString" }
    is_admin { false }
    is_private { false }
    factory :admin do
      is_admin { true }
    end
  end
end
