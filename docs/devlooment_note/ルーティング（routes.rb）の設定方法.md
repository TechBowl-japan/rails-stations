# **Rails ルーティング（routes.rb）の使い方**

## **1. ルート（`get`, `post`, `patch`, `delete`）の基本**
### **① 単純なルート**
```ruby
get "/movies", to: "movies#index"   # GET /movies → movies#index
post "/movies", to: "movies#create" # POST /movies → movies#create
patch "/movies/:id", to: "movies#update" # PATCH /movies/:id → movies#update
delete "/movies/:id", to: "movies#destroy" # DELETE /movies/:id → movies#destroy
```
- `get "/URL", to: "コントローラー#アクション"` の形で定義
- `:id` のような **動的セグメント（URL内の変数）** を使用可能

---

### **② `resources` を使う（RESTfulルートの定義）**
```ruby
resources :movies
```
これは、次のルーティングを **自動生成** します。

| HTTPメソッド | URL | コントローラー#アクション | 用途 |
|-------------|----------------|-----------------|----------------|
| GET        | `/movies`       | `movies#index`  | 映画の一覧表示 |
| GET        | `/movies/new`   | `movies#new`    | 映画の新規作成フォーム |
| POST       | `/movies`       | `movies#create` | 映画の作成 |
| GET        | `/movies/:id`   | `movies#show`   | 映画の詳細表示 |
| GET        | `/movies/:id/edit` | `movies#edit`  | 映画の編集フォーム |
| PATCH/PUT  | `/movies/:id`   | `movies#update` | 映画の更新 |
| DELETE     | `/movies/:id`   | `movies#destroy` | 映画の削除 |

**一部のアクションのみ有効にする**
```ruby
resources :movies, only: [:index, :show]
```
**特定のアクションを除外する**
```ruby
resources :movies, except: [:destroy]
```

---

### **③ `namespace` を使う（管理画面の分離）**
```ruby
namespace :admin do
  resources :movies, only: [:index]
end
```
| HTTPメソッド | URL | コントローラー#アクション |
|-------------|----------------|----------------|
| GET        | `/admin/movies` | `admin/movies#index` |

**ポイント**
- `namespace` を使うと、コントローラーのクラス名が `Admin::MoviesController` になる
- URLにも `admin/` が自動的に付く

---

### **④ `scope` を使う（URLのみ変更、コントローラーはそのまま）**
```ruby
scope :admin do
  resources :movies, only: [:index]
end
```
| HTTPメソッド | URL | コントローラー#アクション |
|-------------|----------------|----------------|
| GET        | `/admin/movies` | `movies#index` |

**違い**
- `namespace` → **コントローラーも `Admin::MoviesController` に変更される**
- `scope` → **URLだけ変更され、コントローラーは変わらない**

---

### **⑤ `root` を使う（アプリのトップページ設定）**
```ruby
root "movies#index"  # "/" で movies#index を表示
```
これは、**`GET /` のリクエストを `movies#index` にルーティング** する設定。

---

### **⑥ `as` を使う（ルート名を変更）**
```ruby
get "up", to: "rails/health#show", as: :rails_health_check
```
- `rails_health_check_path` という名前付きルートを定義。
- `rails_health_check_path` を使うと、`/up` のURLを取得できる。

---

## **2. カスタムルートの定義**
### **① `member`（特定のリソースに対するアクション）**
```ruby
resources :movies do
  member do
    get "preview"
  end
end
```
- `/movies/:id/preview` → `movies#preview` を実行

### **② `collection`（リソース全体に対するアクション）**
```ruby
resources :movies do
  collection do
    get "search"
  end
end
```
- `/movies/search` → `movies#search` を実行

---

## **3. まとめ**
| 方法 | 例 | 用途 |
|------|--------------------------|--------------------------|
| `get` | `get "/movies", to: "movies#index"` | 特定のURLとアクションを紐付け |
| `resources` | `resources :movies` | RESTfulな7つのルートを定義 |
| `namespace` | `namespace :admin do ... end` | URLとコントローラーを分離（`Admin::`） |
| `scope` | `scope :admin do ... end` | URLのみ変更し、コントローラーは変更なし |
| `root` | `root "movies#index"` | トップページを設定 |
| `as` | `get "up", to: "health#show", as: :health_check` | 名前付きルートを設定 |
| `member` | `member do get "preview" end` | `/:id/preview` のような個別アクション |
| `collection` | `collection do get "search" end` | `/search` のようなリソース全体のアクション |

---
