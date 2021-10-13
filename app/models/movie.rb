class Movie < ApplicationRecord
  validates :name, uniqueness: true

  with_options presence: true do
    validates :year
    validates :description
    validates :image_url
    validates :is_showing
    validates :name
  end
end
