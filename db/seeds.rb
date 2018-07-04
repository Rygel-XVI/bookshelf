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
a4 = Author.create!(name: "Placeholder Author")
a5 = Author.create!(name: "David Eddings")

book1 = Book.create!(title:"Weasel", description: "Alone in the frontier wilderness in the winter of 1839, 11-year-old Nathan runs afoul of the renegade killer known as Weasel and makes a surprising discovery about the concept of revenge. The plot contains racial slurs and violence." , word_count: 23960, status: "Available", author_id: 1)

book2 = Book.create!(title: "The Golden Fleece and the Heroes Who Lived Before Achilles", description: "Describes the cycle of myths about the Argonauts and the quest for the Golden Fleece, as well as the tales of the creation of Heaven and Earth, the labors of Hercules, Theseus, and the Minotaur, etc.
", word_count: 77334, status: "Available", author_id: 2)

book3 = Book.create!(title: "Night", description: "This book chronicles the true and terrifying story of the author and his life as a Jew under the Nazis.
", word_count: 28404, status: "Not Available", author_id: 3)

book1 = Book.create!(title:"Polgara the Sorceress", description: "Story about Polgara" , word_count: 456789, status: "Available", author_id: 5)

book4 = Book.create!(title:"Belgarath the Sorcerer", description: "Story about Belgarath" , word_count: 87234, status: "Available", author_id: 5)

book5 = Book.create!(title:"The Elder Gods", description: "Story about Elder Gods" , word_count: 9872, status: "Available", author_id: 5)


UserBook.create!(user_id: 1, book_id: 1, status: "Read")
UserBook.create!(user_id: 1, book_id: 2, status: "Checked Out")
UserBook.create!(user_id: 2, book_id: 1, status: "Read")
UserBook.create!(user_id: 2, book_id: 3, status: "Checked Out")
