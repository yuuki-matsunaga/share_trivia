FactoryBot.define do
  factory :user do
    name { "abc" }
    email { "aaa@bbb" }
    password              { "000000" }
    password_confirmation { "000000" }
  end
end
