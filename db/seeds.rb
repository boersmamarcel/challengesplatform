# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Challenge.create title: "Save the world", description: "It's a hit!", start_date: Date.today >> 1, end_date: Date.today >> 2
Challenge.create title: "Revolutionize Education", description: "About time.", start_date: Date.today >> 1, end_date: Date.today >> 3
Challenge.create title: "Norvig Award", description: "About time.", start_date: Date.today << 1, end_date: Date.today

users = User.create([{"email": "participant@student.utwente.nl"}])
