10.times do
  f = Faker::Name.first_name
  l = Faker::Name.last_name
  Author.create!({
                   first_name: f,
                   last_name: l,
                   email: Faker::Internet.email(name: "#{f}#{l}"),
                   birth_date: Faker::Date.between(from: '1940-01-01', to: '1999-12-30')
                 })
end
