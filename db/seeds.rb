# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

n_column = 5

('a'..'c').each do |char|
	n_column.times do |n|
		Sheet.create([
			{ column: n + 1, row: char }
		])
	end
end
