# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# IDを指定せずにシードデータを登録し、一貫性を保つ
screen1 = Screen.find_or_create_by!(name: 'スクリーン1')
screen2 = Screen.find_or_create_by!(name: 'スクリーン2')
screen3 = Screen.find_or_create_by!(name: 'スクリーン3')

# 座席マスターデータ（全スクリーン共通）
sheets = [
  { column: 1, row: 'a' }, { column: 2, row: 'a' }, { column: 3, row: 'a' }, { column: 4, row: 'a' }, { column: 5, row: 'a' },
  { column: 1, row: 'b' }, { column: 2, row: 'b' }, { column: 3, row: 'b' }, { column: 4, row: 'b' }, { column: 5, row: 'b' },
  { column: 1, row: 'c' }, { column: 2, row: 'c' }, { column: 3, row: 'c' }, { column: 4, row: 'c' }, { column: 5, row: 'c' }
]

# 各スクリーンに対して座席データを作成
[screen1, screen2, screen3].each do |screen|
  sheets.each do |sheet|
    Sheet.find_or_create_by!(column: sheet[:column], row: sheet[:row], screen_id: screen.id)
  end
end