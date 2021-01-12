# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
u1 = User.create(name: "Amanda", username: "mandynvp", email: "mandynvp@gmail.com", password_digest: "iloveyou")

place1 = Place.create(continent: "Europe", country: "England", city: "London", admin_area: "", neighborhood: "Soho", gps_coordinate: "")

s1 = Suggestion.create(title: "Must visit Dishoom!", description: "It's the best Indian cuisine restaurant in the city", place: place1, user: u1)

c1 = Comment.create(text: "London is awesome", user: u1, suggestion: s1)

like1 = Like.create(comment: c1, user: u1)

vote1 = Vote.create(direction: 1, user: u1, suggestion: s1)
