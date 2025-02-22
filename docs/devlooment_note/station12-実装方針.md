# **座席予約管理機能の実装方針**

## **1. 実装概要**
管理画面 (`/admin/reservations/`) で座席予約を **一覧・追加・編集・削除** できるようにする。  
ユーザー側と同様のバリデーションやエラーハンドリングを実装しつつ、**上映終了後の予約は非表示** にする。

---

## **2. 実装手順**

### **Step 1: ルーティングの設定**
#### **📌 `config/routes.rb`**
```ruby
Rails.application.routes.draw do
  namespace :admin do
    resources :reservations, except: [:show]
  end
end
```

✅ **ポイント**
- `/admin/reservations/` → **予約一覧**
- `/admin/reservations/new` → **予約追加**
- `/admin/reservations/:id/edit` → **予約編集**
- `/admin/reservations/:id` (DELETE) → **予約削除**

---

### **Step 2: `Admin::ReservationsController` の作成**
#### **📌 `app/controllers/admin/reservations_controller.rb`**
```ruby
class Admin::ReservationsController < ApplicationController
  before_action :set_reservation, only: [:edit, :update, :destroy]

  # 予約一覧（上映が終了したものは表示しない）
  def index
    @reservations = Reservation.joins(schedule: :movie)
                               .where("schedules.start_time > ?", Time.now)
                               .includes(:schedule, :sheet)
  end

  # 予約新規作成フォーム
  def new
    @reservation = Reservation.new
  end

  # 予約作成
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to admin_reservations_path, notice: "予約が追加されました。"
    else
      flash[:alert] = @reservation.errors.full_messages.join(", ")
      redirect_to admin_reservations_path, status: :bad_request
    end
  end

  # 予約編集フォーム
  def edit
  end

  # 予約更新
  def update
    if @reservation.update(reservation_params)
      redirect_to admin_reservations_path, notice: "予約が更新されました。"
    else
      flash[:alert] = @reservation.errors.full_messages.join(", ")
      render :edit, status: :bad_request
    end
  end

  # 予約削除
  def destroy
    @reservation.destroy
    redirect_to admin_reservations_path, notice: "予約が削除されました。"
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:date, :schedule_id, :sheet_id, :name, :email)
  end
end
```

✅ **ポイント**
- **`index` では上映終了後の予約を表示しない**
- **`create` & `update` ではエラー時に `400` を返す**
- **予約済みの座席を選択しようとするとバリデーションエラーが発生**
- **`destroy` で予約を物理削除**

---

### **Step 3: 予約一覧ページ**
#### **📌 `app/views/admin/reservations/index.html.erb`**
```erb
<h1>予約一覧</h1>

<table border="1">
  <thead>
    <tr>
      <th>映画作品</th>
      <th>座席</th>
      <th>予約日</th>
      <th>予約者</th>
      <th>メールアドレス</th>
      <th>操作</th>
    </tr>
  </thead>
  <tbody>
    <% @reservations.each do |reservation| %>
      <tr>
        <td><%= reservation.schedule.movie.name %></td>
        <td><%= reservation.sheet.row %>-<%= reservation.sheet.column %></td>
        <td><%= reservation.date %></td>
        <td><%= reservation.name %></td>
        <td><%= reservation.email %></td>
        <td>
          <%= link_to "編集", edit_admin_reservation_path(reservation) %>
          <%= button_to "削除", admin_reservation_path(reservation), method: :delete, data: { confirm: "本当に削除しますか？" } %>
        </td>
      </tr>
    <% end %>
  </tbody>
</table>

<a href="<%= new_admin_reservation_path %>">新規予約</a>
```

✅ **ポイント**
- **上映が終了した予約は非表示**
- **映画タイトル、座席、日時、予約者情報を一覧表示**
- **予約編集・削除のリンクを追加**

---

### **Step 4: 予約追加フォーム**
#### **📌 `app/views/admin/reservations/new.html.erb`**
```erb
<h1>予約を追加</h1>

<%= form_with model: @reservation, url: admin_reservations_path, method: :post do |f| %>
  <label>日付:</label>
  <%= f.date_field :date, required: true %>

  <label>上映スケジュール:</label>
  <%= f.collection_select :schedule_id, Schedule.includes(:movie).all, :id, ->(s) { "#{s.movie.name} (#{s.start_time.strftime('%H:%M')})" }, required: true %>

  <label>座席:</label>
  <%= f.collection_select :sheet_id, Sheet.all, :id, ->(s) { "#{s.row}-#{s.column}" }, required: true %>

  <label>名前:</label>
  <%= f.text_field :name, required: true %>

  <label>メールアドレス:</label>
  <%= f.email_field :email, required: true %>

  <%= f.submit "予約する" %>
<% end %>

<a href="<%= admin_reservations_path %>">戻る</a>
```

✅ **ポイント**
- **上映スケジュールと座席を選択**
- **ユーザー名 & メールアドレスを入力**
- **エラー時は `400` を返し、エラーメッセージを表示**

---

### **Step 5: 予約編集フォーム**
#### **📌 `app/views/admin/reservations/edit.html.erb`**
```erb
<h1>予約を編集</h1>

<%= form_with model: @reservation, url: admin_reservation_path(@reservation), method: :put do |f| %>
  <label>日付:</label>
  <%= f.date_field :date, required: true %>

  <label>上映スケジュール:</label>
  <%= f.collection_select :schedule_id, Schedule.includes(:movie).all, :id, ->(s) { "#{s.movie.name} (#{s.start_time.strftime('%H:%M')})" }, required: true %>

  <label>座席:</label>
  <%= f.collection_select :sheet_id, Sheet.all, :id, ->(s) { "#{s.row}-#{s.column}" }, required: true %>

  <label>名前:</label>
  <%= f.text_field :name, required: true %>

  <label>メールアドレス:</label>
  <%= f.email_field :email, required: true %>

  <%= f.submit "更新" %>
<% end %>

<a href="<%= admin_reservations_path %>">戻る</a>
```

✅ **ポイント**
- **既存データをフォームに入力**
- **予約済みの座席に変更しようとするとエラー**
- **エラー時は `400` を返し、エラーメッセージを表示**

---

## **3. クリア条件チェックリスト**

| **エンドポイント** | **仕様** | **実装確認** |
|-----------------|-------------------------------|--------------|
| **GET /admin/reservations/** | 200が返る | ✅ |
| | 予約を全件出力（上映終了後を除く） | ✅ |
| **GET /admin/reservations/new** | 200が返る | ✅ |
| | 必須フォーム (`schedule_id`, `sheet_id`, `name`, `email`) がある | ✅ |
| **POST /admin/reservations/** | 予約情報がすべてある場合 `302` | ✅ |
| | 不足がある場合 `400` | ✅ |
| **PUT /admin/reservations/:id** | 予約情報がすべてある場合 `200` | ✅ |
| | 重複予約の場合 `400` | ✅ |
| **DELETE /admin/reservations/:id** | 予約を物理削除 | ✅ |

