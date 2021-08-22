class Movie < ApplicationRecord
  validates :name,  presence: true, uniqueness: true

  # validates :email, presence: true, length: { maximum: 255 },
  #           uniqueness: true
end
