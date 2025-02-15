# **映画削除機能 実装手順書**

## **1. 実装手順**

### **Step 1: ルーティングの追加**
```ruby
namespace :admin do
  resources :movies, only: [:index, :new, :create, :edit, :update, :destroy]
end
```

| HTTPメソッド | URL | アクション | 用途 |
|-------------|-----|------------|------|
| DELETE | `/admin/movies/:id` | `destroy` | 映画データの削除 |

---

### **Step 2: コントローラーの更新**
`app/controllers/admin/movies_controller.rb`に以下のアクションを追加：

```ruby
class Admin::MoviesController < ApplicationController
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to admin_movies_path, notice: "映画「#{@movie.name}」を削除しました"
  end
end
```

---

### **Step 3: ビューの更新**

#### **編集画面に削除ボタンを追加**
`app/views/admin/movies/edit.html.erb`:
```erb
<h1>映画情報の編集</h1>

<%= render 'form', submit_text: '更新' %>

<div class="delete-section">
  <%= link_to '削除', 
      admin_movie_path(@movie), 
      method: :delete,
      data: { confirm: "映画「#{@movie.name}」を削除してもよろしいですか？" },
      class: 'delete-button' %>
</div>

<%= link_to '一覧に戻る', admin_movies_path %>
```

---

## **2. 実装のポイント**

### **✅ 削除機能の実装**
- **物理削除の実装**
  - `destroy`メソッドを使用して完全に削除
  - 論理削除（soft delete）は不要

### **✅ 確認ダイアログ**
- **data-confirm属性の使用**
  - 削除前に確認ダイアログを表示
  - 誤操作防止のため、映画タイトルを確認メッセージに含める

### **✅ エラーハンドリング**
- **レコード不在エラー**
  - 存在しないIDにアクセスした場合の処理
- **削除失敗時の処理**
  - データベースエラー等の例外処理

### **✅ リダイレクト**
| 状況 | 遷移先 | 備考 |
|------|--------|------|
| 削除成功時 | 一覧ページ | 成功メッセージを表示 |
| エラー時 | 一覧ページ | エラーメッセージを表示 |

---

## **3. セキュリティ考慮事項**

### **1. CSRF対策**
- **authenticity_token**の確認
  - フォームに自動的に含まれる
  - DELETE リクエストでも有効

### **2. 認可チェック**
- 必要に応じて管理者権限チェックを追加

---

## **4. 実装手順**

1. **ルーティングの追加**
   - `resources :movies`に`:destroy`アクションを追加

2. **コントローラーの更新**
   - `destroy`アクションの実装
   - エラーハンドリングの追加
   - フラッシュメッセージの設定

3. **ビューの更新**
   - 編集画面に削除ボタンを追加
   - 確認ダイアログの設定

4. **動作確認**
   - 削除機能の動作確認
   - 確認ダイアログの表示確認
   - リダイレクトとメッセージ表示の確認
   - エラーケースの確認

---

## **5. テスト項目**

### **機能テスト**
1. 削除ボタンクリックで確認ダイアログが表示されること
2. キャンセル時にレコードが削除されないこと
3. OK時にレコードが削除されること
4. 削除後に一覧画面に遷移すること
5. 削除完了のフラッシュメッセージが表示されること

### **異常系テスト**
1. 存在しないIDの削除リクエストのハンドリング
2. データベースエラー時の例外処理