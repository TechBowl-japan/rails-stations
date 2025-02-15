# **映画登録機能 実装手順書**

## **1. 実装手順**
### **Step 1: ルーティングの設定**
管理画面用のルーティングを追加する。
- **GET `/admin/movies/new`** で新規登録フォームを表示
- **POST `/admin/movies`** で映画を登録

| HTTPメソッド | URL | コントローラー#アクション | 用途 |
|-------------|----------------------|----------------------|--------------------------|
| GET        | `/admin/movies/new`  | `admin/movies#new`  | 新規登録フォーム表示 |
| POST       | `/admin/movies`      | `admin/movies#create` | 映画の登録処理 |

```ruby
namespace :admin do
  resources :movies, only: [:new, :create]
end
```

---

### **Step 2: コントローラーの実装**
- `Admin::MoviesController` に以下のアクションを追加
  - **`new` アクション**：新規登録フォームを表示
  - **`create` アクション**：フォームの入力データを受け取り、映画を登録
- 登録成功時に一覧ページへリダイレクト
- 登録エラー時にフォームを再表示し、エラーメッセージを表示

```ruby
class Admin::MoviesController < ApplicationController
  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to admin_movies_path, notice: "映画が登録されました"
    else
      flash.now[:alert] = "登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
  end
end
```

---

### **Step 3: ビューの作成**
- `app/views/admin/movies/new.html.erb` を作成し、新規登録フォームを実装
- フォームには以下の入力項目を設ける
  - **タイトル（name）**
  - **公開年（year）**
  - **概要（description）**（改行を考慮）
  - **画像URL（image_url）**
  - **上映中（is_showing）**（チェックボックス）
- 以下の項目はRailsの機能によってデータベースで自動的に管理される
  - **ID（id）**
  - **登録日時（created_at）**
  - **更新日時（updated_a）**

```erb
<h1>映画の新規登録</h1>

<%= form_with model: @movie, url: admin_movies_path, local: true do |f| %>
  <div>
    <%= f.label :name, "タイトル" %>
    <%= f.text_field :name %>
  </div>

  <div>
    <%= f.label :year, "公開年" %>
    <%= f.number_field :year %>
  </div>

  <div>
    <%= f.label :description, "概要" %>
    <%= f.text_area :description %>
  </div>

  <div>
    <%= f.label :image_url, "画像URL" %>
    <%= f.text_field :image_url %>
  </div>

  <div>
    <%= f.label :is_showing, "上映中" %>
    <%= f.check_box :is_showing %>
  </div>

  <div>
    <%= f.submit "登録" %>
  </div>
<% end %>
```

---

## **2. 実装のポイント**
### **✅ バリデーション**
タイトルの重複チェックを **モデルとデータベース** の両方で行う。

#### **モデルレベル**
```ruby
class Movie < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
```

#### **DBレベル：今回は未実施**
マイグレーションファイルに **ユニーク制約** を追加。


```ruby
class AddUniqueIndexToMovies < ActiveRecord::Migration[7.0]
  def change
    add_index :movies, :name, unique: true
  end
end
```

---

### **✅ エラーハンドリング：今回は未実施**
#### **1. 同じタイトルの登録試行時**
- **400エラー（`unprocessable_entity`）を返す**
- **フラッシュメッセージ** でユーザーに通知

#### **2. その他のエラー**
- Railsのデフォルトのエラー画面を表示しない
- **ユーザーフレンドリーなエラーメッセージ** を表示

```erb
<% if @movie.errors.any? %>
  <div class="error-messages">
    <h2>入力エラーがあります：</h2>
    <ul>
      <% @movie.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
    </ul>
  </div>
<% end %>
```

---

### **✅ フォーム設計**
- **カラム名の日本語表示対応**
- **概要（description）に改行を含める**
- **画像URLの入力フィールドを用意**
- **上映中（is_showing）をチェックボックスで設定**

---

### **✅ リダイレクト**
| 状況 | 遷移先 | 備考 |
|------|--------|----------------------------|
| **登録成功時** | 一覧ページへリダイレクト | `redirect_to admin_movies_path` |
| **エラー時** | フォームを再表示 | 入力値を保持して `render :new` |

---
