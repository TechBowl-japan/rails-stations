class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :sheet

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: { with: EMAIL_REGEX }
  validates :schedule_id, uniqueness: { scope: :sheet_id, message: '同じスケジュールでこのシートは既に予約されています' }
end
