class Reservation < ApplicationRecord
    belongs_to :schedule
    belongs_to :sheet
  
    validates :date, presence: true
    validates :email, presence: true,
    format: { 
        with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, 
        message: "は正しい形式で入力してください" 
      }
    validates :name, presence: true, length: { maximum: 50 }
    validates :schedule_id, uniqueness: { scope: [:date, :sheet_id], message: "はすでに予約されています。" }
    validates :sheet_id, uniqueness: { scope: [:date, :schedule_id], message: "はすでに予約されています。" }
  end