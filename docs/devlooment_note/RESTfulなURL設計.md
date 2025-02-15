# **RESTfulなURL設計**

## **1. RESTfulとは？**
REST（Representational State Transfer）とは、Webサービスの設計原則の1つで、  
**「リソース（データの対象）」に対してHTTPメソッドを適用する** ことで、統一的な設計を実現する。

---

## **2. RESTfulなルーティング**
Railsでは `resources` を使うことで、以下のような **RESTfulなルーティング** を自動生成する。

### **📌 標準のRESTfulルーティング**
```ruby
resources :movies
```

| HTTPメソッド | URL | コントローラー#アクション | 用途 |
|-------------|----------------|-----------------|--------------------------|
| **GET**     | `/movies`       | `movies#index`  | 映画一覧表示 |
| **GET**     | `/movies/new`   | `movies#new`    | 新規登録フォーム表示 |
| **POST**    | `/movies`       | `movies#create` | 映画の新規登録 |
| **GET**     | `/movies/:id`   | `movies#show`   | 映画の詳細表示 |
| **GET**     | `/movies/:id/edit` | `movies#edit`  | 編集フォーム表示 |
| **PATCH/PUT** | `/movies/:id`  | `movies#update` | 映画の更新 |
| **DELETE**  | `/movies/:id`   | `movies#destroy` | 映画の削除 |

---

## **3. `/new` をURLに含めることについて**
### **✅ `GET /movies/new` は一般的な設計か？**
Railsでは **RESTfulなルール** に従い、新規登録フォームは **`/movies/new` に配置** されるのが標準。

| URL | 目的 | 例 |
|-----|------|----|
| `/movies/new` | 新規登録フォーム表示 | Railsの標準 |
| `/movies/create` | 新規登録処理 | 明示的な動詞を使う設計 |
| `/movies/add` | `new` ではなく `add` を使うケース | CMSなどで使われることも |
| `/movies/form` | フォームそのものを指すURL | ユーザーにとってわかりやすい |

---

## **4. 管理画面用のルーティング**
管理画面用のリソースを分離する場合、`namespace :admin` を使う。

### **📌 `namespace` を使ったルーティング**
```ruby
namespace :admin do
  resources :movies, only: [:new, :create]
end
```

### **📌 生成されるルート**
| HTTPメソッド | URL | コントローラー#アクション | 用途 |
|-------------|----------------------|----------------------|--------------------------|
| **GET**     | `/admin/movies/new`  | `admin/movies#new`  | 新規登録フォーム表示 |
| **POST**    | `/admin/movies`      | `admin/movies#create` | 映画の登録処理 |

---

## **5. `new` を別の表現に変更する方法**
もし `new` というURLに違和感がある場合、Railsでは以下のようにカスタムルートを設定できる。

### **📌 `/add` を使用する例**
```ruby
namespace :admin do
  get "movies/add", to: "movies#new", as: :new_admin_movie
end
```

### **📌 変更後のルート**
| URL | 変更前 | 変更後 |
|-----|--------|--------|
| `/admin/movies/new` | 標準的なRESTful設計 | なし |
| `/admin/movies/add` | カスタムURL | **目的を強調** |

- `new_admin_movie_path` を `admin_movies_path("add")` に変更可能

---

## **6. `namespace` と `scope` の違い**
管理画面用のルーティングを設計する場合、**`namespace` と `scope` の使い分け** が重要。

| 方法 | ルーティングの変更 | コントローラーの変更 |
|------|------------------|------------------|
| `namespace` | URLにプレフィックス（`/admin/movies`）を追加 | `Admin::MoviesController` に変更 |
| `scope` | URLにプレフィックスを追加 | コントローラーはそのまま（`MoviesController`）|

### **📌 `namespace` を使用**
```ruby
namespace :admin do
  resources :movies, only: [:new, :create]
end
```
➡️ **コントローラーは `Admin::MoviesController` になる**

### **📌 `scope` を使用**
```ruby
scope :admin do
  resources :movies, only: [:new, :create]
end
```
➡️ **コントローラーは `MoviesController` のまま**

---

## **7. RESTful設計のメリット**
### ✅ **統一されたルールで管理しやすい**
- `resources` を使うことで、一貫したURL構造になる
- どのリソースも同じようなパターンで設計できる

### ✅ **Railsの標準に沿って開発ができる**
- 他のRailsエンジニアがすぐに理解できる
- フレームワークの設計思想に従うことで、学習コストが下がる

### ✅ **RESTful設計を採用すべきケース**
- **Railsのデフォルトのルールに従う場合**
- **RESTfulな設計を重視する場合**
- **他の開発者がRailsの標準ルールに慣れている場合**

### 🚀 **カスタムルーティングを検討すべきケース**
- **エンドユーザー向けに、直感的なURL設計が求められる場合**
- **システムの要件として `/add` や `/create` の方が適している場合**
- **管理画面などで独自のURLパターンが必要な場合**

---

## **8. まとめ**
### ✅ **RESTfulな設計では `/movies/new` は標準的**
- **新規登録フォームは `/movies/new` を使うのが基本**
- **RESTfulなルールに従うのが一般的**

### ✅ **`new` を変更する選択肢もある**
- **`/movies/add` や `/movies/create` も考えられる**
- **Railsの標準にこだわらず、システムに合ったURL設計を検討**

### ✅ **管理画面では `namespace :admin` を使う**
- **`/admin/movies/new` が標準**
- **`/admin/movies/add` に変更する場合は `get "movies/add"` を設定**

---
