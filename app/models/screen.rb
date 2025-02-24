class Screen < ApplicationRecord
    has_many :sheets
    has_many :schedules
    validates :name, presence: true, uniqueness: true
  end
