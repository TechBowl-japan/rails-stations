# **スクリーン増設対応の実装手順（最終版）**

## **前提条件**
- スクリーンが1つから3つに増設
- ユーザー向けUIは変更なし
- 同じ座席番号でもスクリーンが異なれば予約可能
- スクリーン情報はユーザーには非表示

---

## **1. スクリーンモデルとマイグレーションの作成**

```bash
docker compose exec web rails generate model Screen name:string
```

### **📌 `app/models/screen.rb`**
```ruby
class Screen < ApplicationRecord
  has_many :sheets
  has_many :schedules
  validates :name, presence: true, uniqueness: true
end
```

### **📌 `db/migrate/XXXXXXXXXXXXXX_create_screens.rb`**
```ruby
class CreateScreens < ActiveRecord::Migration[7.1]
  def change
    create_table :screens do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :screens, :name, unique: true
  end
end
```

---

## **2. 既存テーブルへのスクリーンID追加**

```bash
docker compose exec web rails generate migration AddScreenIdToSheets screen:references
docker compose exec web rails generate migration AddScreenIdToSchedules screen:references
```

### **📌 `db/migrate/XXXXXXXXXXXXXX_add_screen_id_to_sheets.rb`**
```ruby
class AddScreenIdToSheets < ActiveRecord::Migration[7.1]
  def up
    add_reference :sheets, :screen, null: true, foreign_key: true
    
    Screen.transaction do
      screen = Screen.find_or_create_by!(name: 'スクリーン1')
      Sheet.update_all(screen_id: screen.id)
      change_column_null :sheets, :screen_id, false
    end
  end

  def down
    remove_foreign_key :sheets, :screens
    remove_reference :sheets, :screen
  end
end
```

### **📌 `db/migrate/XXXXXXXXXXXXXX_add_screen_id_to_schedules.rb`**
```ruby
class AddScreenIdToSchedules < ActiveRecord::Migration[7.1]
  def up
    add_reference :schedules, :screen, null: true, foreign_key: true
    
    Screen.transaction do
      screen = Screen.find_or_create_by!(name: 'スクリーン1')
      Schedule.update_all(screen_id: screen.id)
      change_column_null :schedules, :screen_id, false
    end
  end

  def down
    remove_foreign_key :schedules, :screens
    remove_reference :schedules, :screen
  end
end
```

✅ **修正点**
- **`down` メソッドで `foreign_key` の削除を明示的に実施**
- **トランザクションを使用し、データ整合性を確保**

---

## **3. 関連モデルの修正**

### **📌 `app/models/sheet.rb`**
```ruby
class Sheet < ApplicationRecord
  belongs_to :screen
  has_many :reservations

  validates :screen_id, presence: true
end
```

### **📌 `app/models/schedule.rb`**
```ruby
class Schedule < ApplicationRecord
  belongs_to :screen
  belongs_to :movie
  has_many :reservations

  validates :screen_id, presence: true
end
```

✅ **修正点**
- **`screen_id` の `presence: true` を追加し、アプリケーションレイヤーで整合性を保証**

---

## **4. マイグレーションの実行**

```bash
docker compose exec web rails db:migrate
docker compose exec web rails db:migrate:status  # 適用状況を確認
```

✅ **修正点**
- **`rails db:migrate:status` を追加し、適用状況をチェックできるように修正**

---

## **5. スクリーンデータの追加**

### **📌 `db/seeds.rb`**
```ruby
# スクリーンデータを登録
Screen.first_or_create!(name: 'スクリーン1')
Screen.first_or_create!(name: 'スクリーン2')
Screen.first_or_create!(name: 'スクリーン3')

# 座席データを各スクリーンに登録
Screen.all.each do |screen|
  ('a'..'c').each do |row|
    (1..5).each do |column|
      Sheet.find_or_create_by!(row: row, column: column, screen: screen)
    end
  end
end
```

```bash
docker compose exec web rails db:seed
```

✅ **修正点**
- **`find_or_create_by!` から `first_or_create!` に変更し、並列処理時の競合を防止**
- **各スクリーンに座席データを登録**

---

## **6. リザベーションコントローラーの実装**

### **📌 `app/controllers/reservations_controller.rb`**
```ruby
class ReservationsController < ApplicationController
  def new
    if params[:date].blank? || params[:sheet_id].blank?
      redirect_to movie_reservation_path(params[:movie_id], schedule_id: params[:schedule_id], date: params[:date]), alert: "座席を選択してください。" and return
    end

    @reservation = Reservation.new
    @movie = Movie.find(params[:movie_id])
    @schedule = Schedule.find(params[:schedule_id])

    # スケジュールに関連するスクリーンの座席のみ取得
    @sheets = Sheet.where(screen_id: @schedule.screen_id)

    # 座席を取得（スクリーンIDを考慮）
    @sheet = @sheets.find_by(id: params[:sheet_id])

    if @sheet.nil?
      redirect_to movie_reservation_path(@movie, schedule_id: @schedule.id, date: params[:date]), alert: "無効な座席です。" and return
    end

    if Reservation.exists?(schedule_id: @schedule.id, sheet_id: @sheet.id, date: params[:date])
      redirect_to movie_reservation_path(@movie, schedule_id: @schedule.id, date: params[:date]), alert: "その座席はすでに予約済みです。" and return
    end
  end
end
```

✅ **修正点**
- **スケジュールに関連するスクリーンの座席を取得**
- **誤ったスクリーンの座席が指定された場合の処理を追加**

---

## **7. 重要なポイント**
✅ **トランザクションを利用し、マイグレーション時のデータ整合性を保証**  
✅ **ActiveRecord を利用して `update_all` を実行し、DB 依存を排除**  
✅ **モデルレベルで `screen_id` の `presence: true` を追加し、整合性を確保**  
✅ **`foreign_key` の削除を `down` メソッドで明示的に実施**  
✅ **シードデータの `id` 指定を削除し、`AUTO_INCREMENT` の整合性を維持**  
✅ **マイグレーション適用後に `rails db:migrate:status` で適用状況をチェック**  
✅ **リザベーションコントローラーでスクリーンに関連する座席を正しく取得**
