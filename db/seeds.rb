# 10.times do
#     f = Faker::Name.first_name
#     l = Faker::Name.last_name
#     Author.create({
#         first_name: f,
#         last_name: l,
#         email: Faker::Internet.email(name: "#{f}#{l}"),
#         birth_date: Faker::Date.between(from: '1940-01-01', to: '1999-12-30')
#     })
# end

# 5.times do
#     Publisher.create({
#         name: Faker::Company.name,
#         telephone: Faker::PhoneNumber.cell_phone,
#         address: Faker::Address.full_address
#     })
# end

50.times do
    cd = Faker::Date.between(from: '1960-01-01', to: '2010-12-30')
    Book.create!({
        title: Faker::Book.title,
        description: Faker::Lorem.sentence,
        visibility_status: Faker::Boolean.boolean,
        creation_date: cd.to_s,
        isbn: Faker::Number.number(digits: 13).to_s,
        author_id: Faker::Number.within(range: 1..10),
        publisher_id: Faker::Number.within(range: 1..5)
    })
end
