# **座席予約機能の実装方針**

## **1. 実装概要**
- 映画の上映スケジュールに対して、座席予約機能を追加する。  
- ユーザー登録は不要で、予約時に **名前とメールアドレス** を入力してもらう。

### **実装するページとURL一覧**

#### **映画関連**
- **映画詳細ページ:** `GET /movies/:id`
  - 日付選択プルダウン
  - 上映スケジュール選択プルダウン
  - 「座席を予約する」ボタン（クリックで `/movies/:movie_id/reservation` に遷移）

#### **座席予約関連**
- **座席表:** `GET /movies/:movie_id/reservation`
  - クエリパラメータ `date` を受け取る
  - スケジュール選択後の座席一覧
- **座席予約フォーム:** `GET /movies/:movie_id/schedules/:schedule_id/reservations/new`
  - クエリパラメータ `date`、`sheet_id` を受け取る
  - ユーザーが名前・メールアドレスを入力
  - **メールアドレスのバリデーション** を実施
- **予約データの保存:** `POST /reservations`
  - **映画ID・スケジュールID・座席ID・日付・ユーザー情報を保存**
  - **すでに予約済みの場合、エラーメッセージを表示し予約ページにリダイレクト**
- **予約完了ページ:** `GET /movies/:movie_id`
  - **予約完了メッセージをフラッシュ表示**

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

### **Step 2: `reservations` テーブルの作成**

1. マイグレーションファイルの生成
```bash
docker compose run --rm web rails generate migration CreateReservations
```

2. 生成されたマイグレーションファイルに以下の内容を記述
#### **📌 `db/migrate/YYYYMMDDHHMMSS_create_reservations.rb`**
```ruby
class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.date :date, null: false
      t.references :schedule, null: false, foreign_key: true
      t.references :sheet, null: false, foreign_key: true
      t.string :email, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :reservations, [:date, :schedule_id, :sheet_id], unique: true
  end
end
```

3. マイグレーションの実行
```bash
docker compose run --rm web rails db:migrate
```

これにより`schema.rb`が自動的に更新されます。
```sh
rails db:migrate
```

---

### **Step 3: `Reservation` モデルの作成**
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

---

### **Step 4: 映画詳細ページの実装**
#### **📌 `app/views/movies/show.html.erb`**
```erb
<h1><%= @movie.name %></h1>
<p>公開年: <%= @movie.year %></p>
<p><%= @movie.description %></p>
<img src="<%= @movie.image_url %>" alt="<%= @movie.name %>">

<form action="<%= reservation_movie_path(@movie) %>" method="get">
  <label for="date">予約日:</label>
  <select name="date" id="date">
    <% (0..6).each do |i| %>
      <option value="<%= Date.today + i %>"><%= (Date.today + i).strftime("%Y-%m-%d") %></option>
    <% end %>
  </select>

  <label for="schedule">上映スケジュール:</label>
  <select name="schedule_id" id="schedule">
    <% @movie.schedules.each do |schedule| %>
      <option value="<%= schedule.id %>"><%= schedule.start_time.strftime("%H:%M") %></option>
    <% end %>
  </select>

  <input type="submit" value="座席を予約する">
</form>
```

---

### **Step 5: 座席表の表示**
#### **📌 `app/controllers/movies_controller.rb`**
```ruby
class MoviesController < ApplicationController
  def reservation
    if params[:date].blank? || params[:schedule_id].blank?
      redirect_to movie_path(params[:movie_id]), alert: "日付とスケジュールを選択してください。" and return
    end

    @movie = Movie.find(params[:movie_id])
    @schedule = Schedule.find(params[:schedule_id])
    @sheets = Sheet.all
  end
end
```

#### **📌 `app/views/movies/reservation.html.erb`**
```erb
<h1>座席表 - <%= @movie.name %> (<%= params[:date] %>)</h1>

<table border="1">
  <% @sheets.group_by(&:row).each do |row, sheets| %>
    <tr>
      <% sheets.each do |sheet| %>
        <td>
          <a href="<%= new_movie_schedule_reservation_path(@movie, @schedule, sheet_id: sheet.id, date: params[:date]) %>">
            <%= "#{row}-#{sheet.column}" %>
          </a>
        </td>
      <% end %>
    </tr>
  <% end %>
</table>
```

---

### **Step 6: 座席予約フォーム**
#### **📌 `app/controllers/reservations_controller.rb`**
```ruby
class ReservationsController < ApplicationController
  def new
    if params[:date].blank? || params[:sheet_id].blank?
      redirect_to movie_reservation_path(params[:movie_id], schedule_id: params[:schedule_id], date: params[:date]), alert: "座席を選択してください。" and return
    end

    @reservation = Reservation.new
    @movie = Movie.find(params[:movie_id])
    @schedule = Schedule.find(params[:schedule_id])
    @sheet = Sheet.find(params[:sheet_id])
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to movie_path(@reservation.schedule.movie), notice: "予約が完了しました。"
    else
      redirect_to movie_reservation_path(@reservation.schedule.movie, schedule_id: @reservation.schedule_id, date: @reservation.date), alert: "その座席はすでに予約済みです。"
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:date, :schedule_id, :sheet_id, :name, :email)
  end
end
```

#### **📌 `app/views/reservations/new.html.erb`**
```erb
<h1>座席予約</h1>

<p>映画: <%= @movie.name %></p>
<p>上映時刻: <%= @schedule.start_time.strftime("%H:%M") %></p>
<p>座席: <%= @sheet.row %>-<%= @sheet.column %></p>
<p>日付: <%= params[:date] %></p>

<%= form_with model: @reservation, url: reservations_path, method: :post do |f| %>
  <%= f.hidden_field :date, value: params[:date] %>
  <%= f.hidden_field :schedule_id, value: @schedule.id %>
  <%= f.hidden_field :sheet_id, value: @sheet.id %>

  <label>名前:</label>
  <%= f.text_field :name, required: true %>

  <label>メールアドレス:</label>
  <%= f.email_field :email, required: true %>

  <%= f.submit "予約する" %>
<% end %>
```

---
