FactoryBot.define do
  factory :author do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email(name: "#{first_name}#{last_name}") }
    birth_date { Faker::Date.between(from: '1940-01-01', to: '1999-12-30') }
  end
end
