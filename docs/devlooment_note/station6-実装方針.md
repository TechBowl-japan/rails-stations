# **映画検索・フィルタリング機能 実装手順書**

## **1. 実装手順**

### **Step 1: 検索フォームの作成**
`app/views/admin/movies/index.html.erb`:

```erb
<div class="search-section">
  <%= form_with url: admin_movies_path, method: :get, local: true do |f| %>
    <div class="search-field">
      <%= f.text_field :keyword, 
          placeholder: "タイトルまたは概要で検索", 
          value: params[:keyword] %>
    </div>

    <div class="filter-field">
      <%= f.radio_button :is_showing, "", 
          checked: params[:is_showing].blank? %>
      <%= f.label :is_showing_, "すべて" %>

      <%= f.radio_button :is_showing, "1", 
          checked: params[:is_showing] == "1" %>
      <%= f.label :is_showing_1, "上映中" %>

      <%= f.radio_button :is_showing, "0", 
          checked: params[:is_showing] == "0" %>
      <%= f.label :is_showing_0, "上映予定" %>
    </div>

    <%= f.submit "検索" %>
  <% end %>
</div>
```

**補足：form_withのオプション解説**
- `method: :get`: 検索条件をURLに表示させるため
- `local: true`: Ajaxを無効化し、通常のフォーム送信を行う
- `value: params[:keyword]`: 検索後も入力値を保持する
- `checked: params[:is_showing].blank?`: 現在の選択状態を維持する

### **Step 2: コントローラーの更新**
`app/controllers/admin/movies_controller.rb`:

```ruby
def index
  @movies = Movie.all
  @movies = filter_by_showing_status(@movies)
  @movies = filter_by_keyword(@movies)
end

private

def filter_by_showing_status(movies)
  case params[:is_showing]
  when "1"
    movies.where(is_showing: true)
  when "0"
    movies.where(is_showing: false)
  else
    movies
  end
end

def filter_by_keyword(movies)
  if params[:keyword].present?
    movies.where("name LIKE ? OR description LIKE ?", 
                "%#{params[:keyword]}%", 
                "%#{params[:keyword]}%")
  else
    movies
  end
end
```

**補足：ActiveRecordのメソッドチェーン**
- `where`メソッドは新しいActiveRecord::Relationを返す
- メソッドチェーンで複数の条件を組み合わせられる
- 実際のSQLクエリは最後に実行される（遅延評価）

### **Step 3: モデルへのスコープ追加**
`app/models/movie.rb`:

```ruby
class Movie < ApplicationRecord
  scope :showing, -> { where(is_showing: true) }
  scope :scheduled, -> { where(is_showing: false) }
  scope :search_by_keyword, ->(keyword) {
    where("name LIKE ? OR description LIKE ?",
          "%#{keyword}%",
          "%#{keyword}%")
  }
end
```

**補足：スコープとは**
- よく使用する検索条件をモデルに定義する機能
- 他のスコープと組み合わせ可能
- コントローラーをシンプルに保てる
- テストが書きやすくなる

---

## **新しく出てきた概念の解説**

### **1. ActiveRecordのスコープ**
```ruby
scope :name, -> { where(conditions) }
```
- `->`はRubyのラムダ式
- 遅延評価により、必要なタイミングでSQLが実行される
- クラスメソッドとしても使える

### **2. LIKEクエリ**
```sql
WHERE column LIKE '%keyword%'
```
- `%`はワイルドカード（任意の文字列にマッチ）
- 前方一致：`keyword%`
- 後方一致：`%keyword`
- 部分一致：`%keyword%`

### **3. メソッドチェーン**
```ruby
Movie.showing.search_by_keyword("star")
```
- 複数の条件を順番に適用できる
- SQLは最後にまとめて実行される
- 可読性が高く、保守しやすい

### **4. パラメータのバインディング**
```ruby
where("name LIKE ?", "%#{keyword}%")
```
- SQLインジェクション対策
- プレースホルダー（`?`）を使用
- 安全にパラメータを埋め込める

---

## **セキュリティ上の注意点**

### **1. SQLインジェクション対策**
- 生のSQLは使用しない
- ActiveRecordのメソッドを活用
- プレースホルダーを使用

### **2. パラメータのサニタイズ**
```ruby
def sanitize_keyword
  params[:keyword]&.strip
end
```
- 入力値の無害化
- 不要な空白の除去
- 特殊文字のエスケープ

### **3. N+1問題への対応**
```ruby
# 必要に応じてincludesを使用
@movies = Movie.includes(:related_models)
```
- 関連データの効率的な取得
- パフォーマンスの最適化