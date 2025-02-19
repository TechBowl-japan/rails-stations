# **映画作品詳細ページ & 上映スケジュールの実装方針**

## **1. 実装概要**
映画作品の詳細ページ (`GET /movies/:id`) にて、指定された映画の情報を表示する。
また、その映画が **上映中の場合** (`is_showing: true`) は **上映スケジュール（Schedules）** も合わせて表示する。
`movies` テーブルと `schedules` テーブルは **1対Nのリレーション** を持つ。

---

## **2. 実装手順**

### **Step 1: `schedules` テーブルのマイグレーションを作成**
#### **📌 `db/migrate/XXXXXXXXXXXXXX_create_schedules.rb`**
```ruby
class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.references :movie, null: false, foreign_key: true  # 外部キー制約
      t.time :start_time, null: false                      # 上映開始時刻
      t.time :end_time, null: false                        # 上映終了時刻
      t.timestamps
    end
  end
end
```
```bash
# マイグレーションファイル作成
docker compose exec web rails generate migration CreateSchedules
```

#### **📌 マイグレーションの実行**
```sh
rails db:migrate
```

---

### **Step 2: `Schedule` モデルの作成 & アソシエーションの設定**
#### **📌 `app/models/schedule.rb`**
```ruby
class Schedule < ApplicationRecord
  belongs_to :movie
  validates :start_time, presence: true
  validates :end_time, presence: true
end
```
```bash
# Scheduleモデル作成
docker compose exec web rails generate model Schedule
```


#### **📌 `app/models/movie.rb`（既存の `Movie` モデルを編集）**
```ruby
class Movie < ApplicationRecord
  has_many :schedules, dependent: :destroy  # 映画が削除されたらスケジュールも削除
  validates :name, presence: true
  validates :year, presence: true
  validates :description, presence: true
  validates :image_url, presence: true
  validates :is_showing, inclusion: { in: [true, false] }
end
```

---

### **Step 3: `GET /movies/:id` のルーティングを設定**
#### **📌 `config/routes.rb`**
```ruby
Rails.application.routes.draw do
  resources :movies, only: [:show]  # 映画詳細ページのみ有効化
end
```

---

### **Step 4: `MoviesController` の実装**
#### **📌 `app/controllers/movies_controller.rb`**
```ruby
class MoviesController < ApplicationController
  def show
    @movie = Movie.find(params[:id])
    @schedules = @movie.is_showing ? @movie.schedules.order(:start_time) : nil
  end
end
```

---

### **Step 5: 映画詳細ページのビューを作成**
#### **📌 `app/views/movies/show.html.erb`**
```erb
<h1><%= @movie.name %></h1>
<p>公開年: <%= @movie.year %></p>
<p><%= @movie.description %></p>

<% if @movie.image_url.present? %>
  <img src="<%= @movie.image_url %>" alt="<%= @movie.name %>" width="300">
<% end %>

<% if @movie.is_showing && @schedules.present? %>
  <h2>上映スケジュール</h2>
  <table border="1">
    <thead>
      <tr>
        <th>開始時間</th>
        <th>終了時間</th>
      </tr>
    </thead>
    <tbody>
      <% @schedules.each do |schedule| %>
        <tr>
          <td><%= schedule.start_time.strftime("%H:%M") %></td>
          <td><%= schedule.end_time.strftime("%H:%M") %></td>
        </tr>
      <% end %>
    </tbody>
  </table>
<% else %>
  <p>現在、この映画の上映スケジュールはありません。</p>
<% end %>
```

---

### **Step 6: 動作確認 & Git にプッシュ**
1. **マイグレーションを適用**
   ```sh
   rails db:migrate
   ```
2. **テストデータを作成**
   ```sh
   rails console
   ```
   ```ruby
   movie = Movie.create!(
     name: "インセプション",
     year: 2010,
     description: "夢の中の夢を扱う映画",
     image_url: "https://example.com/inception.jpg",
     is_showing: true
   )

   Schedule.create!(movie: movie, start_time: "10:00", end_time: "12:30")
   Schedule.create!(movie: movie, start_time: "14:00", end_time: "16:30")
   ```
3. **サーバーを起動し、動作確認**
   ```sh
   rails s
   ```
   - ブラウザで `http://localhost:3000/movies/1` を開く
   - 映画の詳細ページが表示され、上映スケジュールも確認できる

4. **Git にプッシュ**
   ```sh
   git add .
   git commit -m "映画詳細ページ & 上映スケジュール実装"
   git push
   ```

---

✅ **この方針で進めれば、シンプルかつ拡張しやすい設計になります！** 🚀
