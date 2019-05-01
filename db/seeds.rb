# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Person.create!(first_name: "Example",
                last_name: "User",
                email: "example@example.com",
                password: "foobar",
                activated: true,
                activated_at: Time.zone.now)
                
99.times do |n|
    fname = Faker::Name.name
    lname = Faker::Name.name
    email = "example-#{n+1}@example.com"
    password = "password"
    User.create!(first_name: fname,
                last_name: lname,
                email: email,
                password: password,
                activated: true,
                activated_at: Time.zone.now)
end