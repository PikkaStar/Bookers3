# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |n|
  user = User.create!(
    name: "試験#{n + 1}",
    email: "test#{n + 1}@test.com",
    password: "100100"
  )

  rand(1..3).times do
    user.books.create!(
      title: "テストタイトル#{n + 1}",
      body: "テスト内容#{n + 1}"
      )
  end

  users = User.all
  books = Book.all

  users.each do |user|
    favorite_books = books.sample(rand(1..5))
    favorite_books.each do |book|
      Favorite.find_or_create_by!(
        user_id: user.id,
        book_id: book.id
        )
    end
  end
end