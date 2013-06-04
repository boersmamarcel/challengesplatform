# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new(
  :firstname => "Sciencechallenges", 
  :lastname => "", 
  :email => "challenge@localhost", 
  :notify_by_email => false
)
user.role = 1
user.active = false
user.encrypted_password = "" # Can't fake that!
user.save(validate: false)

load(Rails.root.join('db', 'seeds', "#{Rails.env.downcase}.rb"))
