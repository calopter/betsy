# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'


REVIEW_FILE = Rails.root.join('db', 'seed_data'),'reviews.csv'
puts "Loading raw review data from #{REVIEW_FILE}"

review_failures = []

CSV.foreach(REVIEW_FILE, :headers => true) do |row|
  review = Review.new
  review.id = row['id']
  review.product_id = row['product_id']
  review.message = row['message']
  review.rating = row['rating']
  successful = review.save
  
  if !successful
    review_failures << review
    puts "Failed to save review: #{review.inspect}"
  else
    puts "Created review: #{review.inspect}"
  end
end

puts "Added #{Review.count} review records"
puts "#{review_failures.length} reviews failed to save "
