class Sheet < ApplicationRecord
    has_many :reservations
    validates :column, presence: true, numericality: { only_integer: true }
    validates :row, presence: true, length: { is: 1 }
end
