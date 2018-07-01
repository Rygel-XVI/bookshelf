# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u1 = User.create!(name: "user1", password: "123")
u2 = User.create!(name: "user2", password: "123")
u3 = User.create!(name: "user3", password: "123")
u4 = User.create!(name: "user4", password: "123")
u5 = User.create!(name: "admin1", password: "123", admin: true)

a1 = Author.create!(name: "DeFelice, Cynthia")
a2 = Author.create!(name: "Colum, Padraic")
a3 = Author.create!(name: "Wiesel, Elie")

book1 = Book.create!(title:"Weasel", description: "Alone in the frontier wilderness in the winter of 1839, 11-year-old Nathan runs afoul of the renegade killer known as Weasel and makes a surprising discovery about the concept of revenge. The plot contains racial slurs and violence." , word_count: 23960, status: "Available", author_id: 1)


book2 = Book.create!(title: "The Golden Fleece and the Heroes Who Lived Before Achilles", description: "Describes the cycle of myths about the Argonauts and the quest for the Golden Fleece, as well as the tales of the creation of Heaven and Earth, the labors of Hercules, Theseus, and the Minotaur, etc.
", word_count: 77334, status: "Available", author_id: 2)

book3 = Book.create!(title: "Night", description: "This book chronicles the true and terrifying story of the author and his life as a Jew under the Nazis.
", word_count: 28404, status: "Not Available", author_id: 3)

u1.books << book1
u1.user_books.first.update!(status: "Read")
u1.books << book2
u1.user_books.last.update!(status: "Checked Out")


u3.books << book3
u3.user_books.first.update!(status: "Read")
u3.books << book1
u3.user_books.last.update!(status: "Checked Out")
