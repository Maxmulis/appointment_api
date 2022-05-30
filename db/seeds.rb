# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'json'

file = File.read(Rails.root.join('db', 'lib', 'realtors.json'))
realtors = JSON.parse(file)

realtors.each do |realtor|
  realtor.transform_keys! { |key| key.to_sym }
  realtor[:longitude] = realtor.delete(:lng)
  realtor[:latitude] = realtor.delete(:lat)
  Realtor.create(realtor)
  puts "Created realtor #{realtor[:name]}"
end
