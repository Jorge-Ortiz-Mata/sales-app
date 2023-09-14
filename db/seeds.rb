# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.development?
  puts 'Seeding Categories...'
  require_relative './categories_seed'

  puts 'Seeding Articles...'
  require_relative './articles_seed'

  # puts 'Seeding Sells...'
  # require_relative './sells_seed'
end
