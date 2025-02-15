class Movie < ApplicationRecord
    # バリデーション presence: true → 各フィールドが必須（空を許可しない）
    # uniqueness: true → 一意でなければならない
    validates :name, presence: true, uniqueness: true
    validates :year, presence: true
    validates :description, presence: true
    validates :image_url, presence: true
    validates :is_showing, presence: true

    # フィルタリング
    scope :showing, -> { where(is_showing: true)}
    scope :not_showing, -> { where(is_showing: false)}
    scope :search_by_keyword, -> (keyword) {
      where("name LIKE ? OR description LIKE ?",
        "%#{keyword}%",
        "%#{keyword}%")
    }
end
