FactoryBot.define do
  factory :publisher do
    name { Faker::Company.name }
    telephone { Faker::PhoneNumber.cell_phone }
    address { Faker::Address.full_address }
  end
end
