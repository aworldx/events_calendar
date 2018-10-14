FactoryBot.define do
  factory :user do
    name { 'Joe' }
    email { 'joe@gmail.com' }
    password { '1234567890' }
    password_confirmation { '1234567890' }
  end
end
