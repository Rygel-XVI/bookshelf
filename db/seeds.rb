# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Author.create!(name: "George R. R. Martin")
Author.create!(name: "Robert Jordan")
Author.create!(name: "Leslie Feinberg")

book = Book.new(title: "Wheel of Time", description: "Series by Robert Jordan, he died before finishing D=", word_count: 99999999)
book.author = Author.find_by(name: "Robert Jordan")
book.save!

book = Book.new(title: "Game of Thrones", description: "Factions fight over the iron throne whilst being threatened by an old enemy to the North", word_count: 532)
book.author = Author.find_by(name: "George R. R. Martin")
book.save!

book = Book.new(title: "Stone Butch Blues", description: "Historical account of the gay community in Upstate NY a few decades ago.", word_count: 328)
book.author = Author.find_by(name: "Leslie Feinberg")
book.save!

user = User.new(provider: "testprovider", email: "email@test.com")
user.password = Devise.friendly_token[0,20]
user.books < Book.first
user.books < Book.find_by(title: "Game of Thrones")
user.books < Book.last
user.save!
