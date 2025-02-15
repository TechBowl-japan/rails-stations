# **映画編集機能 実装手順書**

## **1. 実装手順**

### **Step 1: ルーティングの追加**
```ruby
namespace :admin do
  resources :movies, only: [:index, :new, :create, :edit, :update]
end
```

| HTTPメソッド | URL | アクション | 用途 |
|-------------|-----|------------|------|
| GET | `/admin/movies/:id/edit` | `edit` | 編集フォーム表示 |
| PUT/PATCH | `/admin/movies/:id` | `update` | 更新処理実行 |

---

### **Step 2: コントローラーの更新**
`app/controllers/admin/movies_controller.rb`に以下のアクションを追加：

```ruby
class Admin::MoviesController < ApplicationController
  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to admin_movies_path, notice: "映画情報が更新されました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end
end
```

---

### **Step 3: ビューの作成と更新**

#### **1. 編集フォームの作成**
`app/views/admin/movies/edit.html.erb`:
```erb
<h1>映画情報の編集</h1>

<%= form_with model: [:admin, @movie], local: true do |f| %>
  <!-- 新規登録フォームと同じフォーム部分をここに配置 -->
  <!-- エラーメッセージ表示部分も含める -->
<% end %>

<%= link_to '一覧に戻る', admin_movies_path %>
```

#### **2. 一覧画面の更新**
`app/views/admin/movies/index.html.erb`のID列を編集リンクに変更：
```erb
<td><%= link_to movie.id, edit_admin_movie_path(movie) %></td>
```

---

## **2. 実装のポイント**

### **✅ フォーム設計**
- **既存データの表示**
  - 編集フォームを開いた時に、現在の値が入力済みの状態にする
- **フォーム共通化の検討**
  - 新規作成と編集で同じフォーム部分を共有（パーシャル化）を検討

### **✅ エラーハンドリング**
- **バリデーションエラー**
  - 新規登録時と同様のエラー処理
  - フォームを再表示し、エラーメッセージを表示
- **レコード不在エラー**
  - 存在しないIDにアクセスした場合の処理

### **✅ リダイレクト**
| 状況 | 遷移先 | 備考 |
|------|--------|------|
| 更新成功時 | 一覧ページ | 成功メッセージを表示 |
| エラー時 | 編集フォーム | エラーメッセージを表示 |

---

## **3. リファクタリングのポイント**

### **1. フォームの共通化**
新規作成と編集で使用するフォームをパーシャル化：

```erb
# app/views/admin/movies/_form.html.erb
<%= form_with model: [:admin, @movie], local: true do |f| %>
  <!-- 共通のフォーム部分 -->
<% end %>
```

### **2. バリデーションの確認**
- 既存のバリデーションが編集時にも適切に機能するか確認
- 特に一意性制約に関する処理の確認

---

## **4. 実装手順**

1. **ルーティングの追加**
   - `edit`と`update`アクションの追加

2. **コントローラーの更新**
   - `edit`アクションの実装
   - `update`アクションの実装
   - エラーハンドリングの追加

3. **ビューの作成**
   - 編集フォームの作成
   - 一覧画面のリンク追加
   - フォームのパーシャル化

4. **動作確認**
   - 既存データの編集
   - バリデーションの確認
   - エラー時の動作確認