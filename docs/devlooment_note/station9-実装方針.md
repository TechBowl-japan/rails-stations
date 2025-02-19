# **上映スケジュール管理ページの実装方針**

## **1. 実装概要**
管理画面 (`/admin/schedules`) で **上映スケジュールの一覧・追加・編集・削除** をできるようにする。  
映画作品 (`movies`) に紐づいた形でスケジュールを管理し、スケジュール一覧への遷移は映画詳細ページ (`/admin/movies/:id`) から行う。

---

## **2. 実装手順**

### **Step 1: ルーティングの設定**
#### **📌 `config/routes.rb`**
```ruby
Rails.application.routes.draw do
  namespace :admin do
    resources :movies, only: [:index, :show] do
      resources :schedules, only: [:new, :create]
    end

    resources :schedules, only: [:index, :show, :edit, :update, :destroy]
  end
end
```

---

### **Step 2: `Admin::SchedulesController` の作成**
#### **📌 `app/controllers/admin/schedules_controller.rb`**
```ruby
class Admin::SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  def index
    @schedules_by_movie = Schedule.includes(:movie).group_by(&:movie)
  end

  def show
  end

  def new
    @movie = Movie.find(params[:movie_id])
    @schedule = @movie.schedules.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @schedule = @movie.schedules.build(schedule_params)

    if @schedule.save
      redirect_to admin_schedules_path, notice: "スケジュールを追加しました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to admin_schedule_path(@schedule), notice: "スケジュールを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @schedule.destroy
    redirect_to admin_schedules_path, notice: "スケジュールを削除しました。"
  end

  private

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end

  def schedule_params
    params.require(:schedule).permit(:start_time, :end_time)
  end
end
```

---

### **Step 3: スケジュール一覧 (`GET /admin/schedules`)**
#### **📌 `app/views/admin/schedules/index.html.erb`**
```erb
<h1>上映スケジュール一覧</h1>

<% @schedules_by_movie.each do |movie, schedules| %>
  <h2><%= movie.name %>（作品ID: <%= movie.id %>）</h2>
  <ul>
    <% schedules.each do |schedule| %>
      <li>
        開始: <%= schedule.start_time.strftime("%H:%M") %> - 終了: <%= schedule.end_time.strftime("%H:%M") %>
        <a href="<%= admin_schedule_path(schedule) %>">詳細</a>
      </li>
    <% end %>
  </ul>
<% end %>
```

---

### **Step 4: スケジュール詳細 (`GET /admin/schedules/:id`)**
#### **📌 `app/views/admin/schedules/show.html.erb`**
```erb
<h1>スケジュール詳細</h1>

<p>作品ID: <%= @schedule.movie.id %></p>
<p>作品名: <%= @schedule.movie.name %></p>
<p>開始時刻: <%= @schedule.start_time.strftime("%H:%M") %></p>
<p>終了時刻: <%= @schedule.end_time.strftime("%H:%M") %></p>
<p>作成日時: <%= @schedule.created_at %></p>
<p>更新日時: <%= @schedule.updated_at %></p>

<a href="<%= edit_admin_schedule_path(@schedule) %>">編集</a>
<%= button_to "削除", admin_schedule_path(@schedule), method: :delete, data: { confirm: "本当に削除しますか？" } %>
```

---

### **Step 5: スケジュール編集 (`GET /admin/schedules/:id/edit`)**
#### **📌 `app/views/admin/schedules/edit.html.erb`**
```erb
<h1>スケジュール編集</h1>

<%= form_with model: @schedule, url: admin_schedule_path(@schedule), method: :put do |f| %>
  <p>
    <%= f.label :start_time, "開始時刻" %>
    <%= f.time_field :start_time %>
  </p>

  <p>
    <%= f.label :end_time, "終了時刻" %>
    <%= f.time_field :end_time %>
  </p>

  <%= f.submit "更新" %>
<% end %>
```

---

### **Step 6: 映画詳細ページにスケジュール管理リンクを追加**
#### **📌 `app/views/admin/movies/show.html.erb`**
```erb
<h1><%= @movie.name %></h1>

<a href="<%= admin_schedules_path %>">上映スケジュール一覧</a>
<a href="<%= new_admin_movie_schedule_path(@movie) %>">スケジュール追加</a>

<h2>スケジュール一覧</h2>
<ul>
  <% @movie.schedules.each do |schedule| %>
    <li>
      開始: <%= schedule.start_time.strftime("%H:%M") %> - 終了: <%= schedule.end_time.strftime("%H:%M") %>
      <a href="<%= admin_schedule_path(schedule) %>">詳細</a>
    </li>
  <% end %>
</ul>
```

---

## **7. まとめ**
✅ **上映スケジュール管理画面の一覧・詳細・編集・削除を実装**  
✅ **映画作品ごとにスケジュールを管理する設計**  
✅ **映画詳細ページからスケジュール管理画面へ遷移できるようにする**

