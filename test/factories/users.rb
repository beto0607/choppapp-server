FactoryBot.define do
  factory :user do
    email { "MyString" }
    password_digest { "MyString" }
    is_admin { false }
    factory :admin do
      is_admin { true }
    end
  end

end
