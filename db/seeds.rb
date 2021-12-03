# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Movie.create([{ name: 'Star Wars',
                year: '1977',
                description: 'SF',
                image_url:'star_wars.jpg',
                is_showing: 1},
              { name: 'Lord of the Rings',
                year: '2001',
                description: 'Action',
                image_url:'lord_rings.jpg',
                is_showing: 1}])
# 追加のユーザーをまとめて生成する
12.times do |n|
  name  = Faker::Movie.title
  year = "2000"
  description = Faker::Movie.quote
  image_url = "https://picsum.photos/id/#{n}/200/300"
  is_showing = 1
  Movie.create!(name: name,
                year: year,
                description: description,
                image_url: image_url,
                is_showing: is_showing)
  
  end