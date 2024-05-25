class Movie < ApplicationRecord

  # validates :name, uniqueness: true

  validates :name, uniqueness: true, on: :create
  # 更新時のユニークバリデーション
  validate :unique_name_on_update, on: :update

  private
  def unique_name_on_update
    # nameカラムが変更されている場合のみバリデーションを実行
    if name_changed?
      # 他のレコードで同じ名前が存在するか確認
      if self.class.where.not(id: id).exists?(name: name)
        # エラーメッセージを追加
        errors.add(:name, "has already been taken")
      end
    end
  end
end
