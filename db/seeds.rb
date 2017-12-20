# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Role.create(name: "admin")
Role.create(name: "host")
Role.create(name: "guest")

User.create(email: "admin@gmail.com", password: "123456", mobile: "8496918848", first_name: "admin", last_name: "admin", username: "admin", role_id: Role.find_by(name: "admin").id)