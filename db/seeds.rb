# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Movie.create([{ name: '3idiots',
                year: '2000',
                description: 'comedy',
                image_url:'star_wars.jpg',
                is_showing: 1},
              { name: 'jaws',
                year: '2001',
                description: 'Action',
                image_url:'lord_rings.jpg',
                is_showing: 1}])
# 追加のユーザーをまとめて生成する
# 12.times do |n|
#   name  = Faker::Movie.title
#   year = "2000"
#   description = Faker::Movie.quote
#   image_url = "https://picsum.photos/id/#{n}/200/300"
#   is_showing = 0
#   Movie.create!(name: name,
#                 year: year,
#                 description: description,
#                 image_url: image_url,
#                 is_showing: is_showing)
  
#   end

Sheet.create([
  { column: 1, row: 'a'},
  { column: 2, row: 'a'},
  { column: 3, row: 'a'},
  { column: 4, row: 'a'},
  { column: 5, row: 'a'},
  { column: 1, row: 'b'},
  { column: 2, row: 'b'},
  { column: 3, row: 'b'},
  { column: 4, row: 'b'},
  { column: 5, row: 'b'},
  { column: 1, row: 'c'},
  { column: 2, row: 'c'},
  { column: 3, row: 'c'},
  { column: 4, row: 'c'},
  { column: 5, row: 'c'},
])

Schedule.create([
  { movie_id: 1, start_time: Time.at(0), end_time: Time.at(3600)},
  { movie_id: 1, start_time: Time.at(0), end_time: Time.at(3600)},
  { movie_id: 2, start_time: Time.at(0), end_time: Time.at(3600)},
  { movie_id: 3, start_time: Time.at(0), end_time: Time.at(3600)},
])