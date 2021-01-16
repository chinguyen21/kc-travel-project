# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Destination.destroy_all
Event.destroy_all
Entry.destroy_all
Itinerary.destroy_all
Favorite.destroy_all
Review.destroy_all
Country.destroy_all
State.destroy_all
City.destroy_all


50.times {
  Country.create(name: Faker::Address.country)
}
total_countries = Country.all.size

100.times {
  State.create(
    name: Faker::Address.state,
    country: Country.all[rand(1..total_countries)]
    )
}

total_states = State.all.size
300.times {
  City.create(
    name: Faker::Address.city,
    state: State.all[rand(1..total_states)]
    )
}

total_cities = City.all.size
600.times {
  Destination.create(
    name: Faker::Restaurant.name, 
    city: City.all[rand(1..total_cities)],
    picture_link: Faker::LoremFlickr.image(search_terms: ['restaurant']),
    events_attributes: {"0" => {
      name: Faker::Game.title,
      price: rand(1..150)
    }}
  )
}

total_destinations = Destination.all.size

1000.times {
  Event.create(
    name: Faker::Game.title,
    price: rand(1..200),
    destination: Destination.all[rand(1..total_destinations)]
  )
}

total_events = Event.all.size

1000.times {
  Review.create(
    rating: rand(1..10),
    content: Faker::Restaurant.review,
    user_id: 1,
    destination: Destination.all[rand(1..total_destinations)]
  )
}

# We already created a user name admin with user_id = 1 inside our app
