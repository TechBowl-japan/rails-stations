class Sheet < ApplicationRecord
    belongs_to :screen
    has_many :reservations
    validates :column, presence: true, numericality: { only_integer: true }
    validates :row, presence: true, length: { is: 1 }
    validates :screen_id, presence: true
end
