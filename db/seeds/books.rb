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
