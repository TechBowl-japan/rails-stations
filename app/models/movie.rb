class Movie < ApplicationRecord
    # バリデーション presence: true → 各フィールドが必須（空を許可しない）
    validates :name, presence: true
    validates :year, presence: true
    validates :description, presence: true
    validates :image_url, presence: true
    validates :is_showing, presence: true
end