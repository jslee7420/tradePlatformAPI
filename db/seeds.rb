# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: "User1@example.com", password: "user1234")
User.create(email: "User2@example.com", password: "user1234")
User.create(email: "User3@example.com", password: "user1234")
User.create(email: "User4@example.com", password: "user1234")
User.create(email: "User5@example.com", password: "user1234")

Keyword.create(keyword: "abc", count: 2)

UserKeyword.create(user_id: 2, keyword_id: 1)
UserKeyword.create(user_id: 3, keyword_id: 1)
