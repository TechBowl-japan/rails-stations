class Movie < ApplicationRecord
	validates :name, uniqueness: true
end
