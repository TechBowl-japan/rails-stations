class Movie < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
