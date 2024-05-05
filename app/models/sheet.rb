class Sheet < ApplicationRecord
    belongs_to :schedule, optional: true
end
