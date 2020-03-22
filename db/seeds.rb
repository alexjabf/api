# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

40.times do |index|
  puts "Creating user #{index + 1}"
  User.create(email: Faker::Internet.email, uid: rand(1000..5000).to_s,
              password: Devise.friendly_token[0, 20], provider: ['facebook', 'google'].sample)
end

40.times do |index|
  puts "Creating book #{index + 1}"
  Book.create(title: Faker::Book.title, author: Faker::Book.author,
           image: Faker::Avatar.image)
end

400.times do |index|
  puts "Creating review #{index + 1}"
  review = Review.create(book_id: rand(1..40), user_id: rand(1..40), title: Faker::Quote.famous_last_words,
                content_rating: rand(1..5), recommend_rating: rand(1..5))
  review.save(validates: false)
end


