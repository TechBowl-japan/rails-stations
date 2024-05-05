class Movie < ApplicationRecord
    validates :name, presence: true , uniqueness: { scope: %i[screen_id] }
    validates :screen_id, presence: true
    validates :name, presence: true, uniqueness: true
    has_many :schedules, dependent: :destroy
    has_many :sheets
  
end