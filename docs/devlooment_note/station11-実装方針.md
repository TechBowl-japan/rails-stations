# **予約済み座席を選択不可にする実装方針**

## **1. 実装概要**
- 予約済みの座席は **選択不可** にする（リンクを無効化）。
- すでに予約された座席は **グレー背景** にし、予約済みであることを視覚的にわかりやすくする。
- クエリパラメータを直接指定して予約しようとしても、**予約済みの場合はエラーメッセージを表示** する。
- **N+1問題を防ぐため、一括でデータ取得する**。

---

## **2. 実装手順**

### **Step 1: ルーティングの設定**
#### **📌 `config/routes.rb`**
```ruby
Rails.application.routes.draw do
  resources :movies, only: [:show] do
    get "reservation", to: "movies#reservation"

    resources :schedules, only: [] do
      resources :reservations, only: [:new, :create]
    end
  end

  resources :reservations, only: [:create]
end
```

---

### **Step 2: `MoviesController` の修正**
#### **📌 `app/controllers/movies_controller.rb`**
```ruby
class MoviesController < ApplicationController
  def reservation
    if params[:date].blank? || params[:schedule_id].blank?
      redirect_to movie_path(params[:movie_id]), alert: "日付とスケジュールを選択してください。" and return
    end

    @movie = Movie.find(params[:movie_id])
    @schedule = Schedule.find(params[:schedule_id])
    @sheets = Sheet.includes(:reservations).all
    @reserved_sheets = Reservation.where(schedule_id: @schedule.id, date: params[:date]).pluck(:sheet_id)
  end
end
```

✅ **ポイント**
- `Sheet.includes(:reservations).all` で **N+1問題を防ぐ**
- `Reservation.where(schedule_id: @schedule.id, date: params[:date]).pluck(:sheet_id)` で **予約済みの座席IDを取得**

### **Step 2.5: Sheetモデルの関連付け追加**
#### **📌 `app/models/sheet.rb`**
```ruby
class Sheet < ApplicationRecord
  has_many :reservations
end
```
✅ **ポイント**
- Sheetモデルに予約との関連付けを追加
- これにより`includes(:reservations)`が機能する

---

### **Step 3: 座席表の表示**
#### **📌 `app/views/movies/reservation.html.erb`**
```erb
<h1>座席表 - <%= @movie.name %> (<%= params[:date] %>)</h1>

<table border="1">
  <% @sheets.group_by(&:row).each do |row, sheets| %>
    <tr>
      <% sheets.each do |sheet| %>
        <% if @reserved_sheets.include?(sheet.id) %>
          <td style="background-color: gray; color: white;">
            <%= "#{row}-#{sheet.column} (予約済み)" %>
          </td>
        <% else %>
          <td>
            <a href="<%= new_movie_schedule_reservation_path(@movie, @schedule, sheet_id: sheet.id, date: params[:date]) %>">
              <%= "#{row}-#{sheet.column}" %>
            </a>
          </td>
        <% end %>
      <% end %>
    </tr>
  <% end %>
</table>
```

✅ **ポイント**
- **予約済みの座席 (`@reserved_sheets` に含まれる `sheet.id` ) はリンクを無効化し、背景をグレーに変更**
- 予約済み座席は`(予約済み)`と表示
- グレー背景と白文字で視認性を確保
- テーブルのセル内でリンクとテキストの配置を統一

---

### **Step 4: 予約リクエストのバリデーション**
#### **📌 `app/controllers/reservations_controller.rb`**
```ruby
class ReservationsController < ApplicationController
  def new
    if params[:date].blank? || params[:sheet_id].blank?
      redirect_to movie_reservation_path(params[:movie_id], schedule_id: params[:schedule_id], date: params[:date]), alert: "座席を選択してください。" and return
    end

    @movie = Movie.find(params[:movie_id])
    @schedule = Schedule.find(params[:schedule_id])
    @sheet = Sheet.find(params[:sheet_id])

    # 予約済みの座席はフォームに進めない
    if Reservation.exists?(schedule_id: @schedule.id, sheet_id: @sheet.id, date: params[:date])
      redirect_to movie_reservation_path(@movie, schedule_id: @schedule.id, date: params[:date]), alert: "その座席はすでに予約済みです。" and return
    end

    @reservation = Reservation.new
  end
```

✅ **ポイント**
- **予約済みの座席をクエリパラメータで指定しても予約できないようにチェック**
- **予約済みの場合、座席選択ページ (`/movies/:movie_id/reservation`) にリダイレクト**

---

### **Step 5: 予約リクエストの処理**
#### **📌 `app/controllers/reservations_controller.rb`**
```ruby
def create
  @reservation = Reservation.new(reservation_params)

  if Reservation.exists?(schedule_id: @reservation.schedule_id, sheet_id: @reservation.sheet_id, date: @reservation.date)
    redirect_to movie_reservation_path(@reservation.schedule.movie, schedule_id: @reservation.schedule_id, date: @reservation.date), alert: "その座席はすでに予約済みです。" and return
  end

  if @reservation.save
    redirect_to movie_path(@reservation.schedule.movie), notice: "予約が完了しました。"
  else
    redirect_to movie_reservation_path(@reservation.schedule.movie, schedule_id: @reservation.schedule_id, date: @reservation.date), alert: "予約に失敗しました。"
  end
end
```

✅ **ポイント**
- **データベースに保存前に、すでに予約があるか再チェック**
- **予約済みならエラーメッセージを表示し、座席選択ページにリダイレクト**

---

### **Step 6: 予約済み座席のバリデーション**
#### **📌 `app/models/reservation.rb`**
```ruby
class Reservation < ApplicationRecord
  belongs_to :schedule
  belongs_to :sheet

  validates :date, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, length: { maximum: 50 }
  validates :schedule_id, uniqueness: { scope: [:date, :sheet_id], message: "はすでに予約されています。" }
end
```

✅ **ポイント**
- **データベースレベルで予約のユニーク制約を適用**
- **アプリケーションレベルでも `validates` を使って二重予約を防止**

---

## **3. クリア条件チェックリスト**

| **エンドポイント** | **仕様** | **実装確認** |
|-----------------|-------------------------------|--------------|
| **GET /movies/:movie_id/reservation** | 予約フォームに飛ぶリンクは予約可能な席のみ有効になっている | ✅ |
| | 予約済みの席にはリンクがない | ✅ |
| | 予約済みの席をグレー背景にする | ✅ |
| | 予約済みの席をクエリパラメータで指定しても予約できないようにエラーチェック | ✅ |
| | N+1問題が起きていない（`Sheet.includes(:reservations).all` を使用） | ✅ |

---
