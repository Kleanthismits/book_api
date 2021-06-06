5.times do
  Publisher.create!({
                      name: Faker::Company.name,
                      telephone: Faker::PhoneNumber.cell_phone,
                      address: Faker::Address.full_address
                    })
end
