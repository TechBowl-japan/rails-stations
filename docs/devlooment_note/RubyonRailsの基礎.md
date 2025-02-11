# **Ruby on Railsの基礎**

## **1. Railsの基本**

### **Railsとは？**

- **Ruby on Rails** は **MVCアーキテクチャ** を採用した **Webアプリケーションフレームワーク**
- **ActiveRecord** を使ってデータベースを簡単に操作できる
- **Convention over Configuration（設定より規約）** の思想で、規則に従えば簡潔なコードでアプリを開発できる

---

## **2. MVCアーキテクチャ**

Railsは **MVC（Model-View-Controller）** という設計パターンを採用しています。

各コンポーネントの役割を理解することが、Railsをマスターする第一歩です。

| コンポーネント | 役割 | 具体例 |
| --- | --- | --- |
| **Model（M）** | データの管理・保存・更新・削除、バリデーション、ビジネスロジック | `User` モデルでユーザー情報を管理 |
| **View（V）** | HTMLを生成し、ユーザーに画面を表示 | `index.html.erb` でユーザー一覧を表示 |
| **Controller（C）** | リクエストを処理し、モデルとビューを仲介 | `UsersController` でユーザーの一覧を取得し、ビューに渡す |

---

## **3. Railsのフォルダ構成と拡張子**

### **フォルダ構成**

```
myapp/
├── app/                 # アプリの主要なコード（MVC）
│   ├── controllers/     # コントローラー（リクエスト処理）
│   ├── models/          # モデル（データ処理、ビジネスロジック）
│   ├── views/           # ビュー（画面表示、HTMLテンプレート）
│   ├── helpers/         # ビューのヘルパーメソッド
│   ├── assets/          # 静的ファイル（CSS, JS, 画像）
│
├── config/              # アプリの設定ファイル
│   ├── routes.rb        # ルーティング設定
│   ├── database.yml     # データベース設定
│
├── db/                  # データベース関連
│   ├── migrate/         # マイグレーションファイル
│   ├── schema.rb        # DBの構造
│
├── public/              # 静的ファイル（エラーページなど）
├── log/                 # ログファイル
├── test/                # テストコード
├── storage/             # アップロードファイル
└── Gemfile              # 依存ライブラリ管理

```

### **拡張子と用途**

| 拡張子 | 用途 |
| --- | --- |
| `.rb` | Rubyのコード（モデル、コントローラー、設定など） |
| `.erb` | **ERBテンプレート（HTMLにRubyを埋め込める）** |
| `.html.erb` | **HTMLテンプレート（ビュー）** |
| `.json.jbuilder` | **JSONレスポンス（API用）** |
| `.scss` | スタイルシート（CSSの拡張） |
| `.js` | JavaScriptファイル（フロントエンド用） |
| `.yml` | 設定ファイル（データベース、翻訳、Rails設定） |
| `.log` | ログファイル（開発・本番) |

---

# **4. View（ビュー）**

**役割:**

- ユーザーに表示するHTMLを生成
- `ERB（Embedded Ruby）` を使ってRubyのデータを埋め込める
- **共通レイアウト** は `app/views/layouts/application.html.erb` に定義

### **ERBの例**

```ruby
<h1>ユーザー一覧</h1>

<ul>
  <% @users.each do |user| %>
    <li><%= user.full_name %></li>
  <% end %>
</ul>

```

---

## **5. Controller（コントローラー）**

**役割:**

- クライアントの **リクエストを受け取り、適切なデータを取得し、ビューに渡す**
- **モデルとビューを仲介** する

### **コントローラーの作成**

```
rails generate controller Users

```

### **コントローラーの例**

```ruby
class UsersController < ApplicationController
  def index
    @users = User.all  # ユーザー一覧を取得
  end

  def show
    @user = User.find(params[:id])  # 特定のユーザーを取得
  end
end

```

---

## **6. ルーティング（routes.rb）**

Railsでは、リクエストのURLを **コントローラーのアクション** に紐づける **ルーティング** を定義します。

### **基本的なルーティング**

```ruby
Rails.application.routes.draw do
  get "/users", to: "users#index"  # GET /users → UsersController#index
  post "/users", to: "users#create"  # POST /users → UsersController#create
end

```

### **リソースベースのルーティング**

```ruby
Rails.application.routes.draw do
  resources :users  # 7つのアクションを自動生成（index, show, new, create, edit, update, destroy）
end

```

---

## **7. データベースとマイグレーション**

### **マイグレーションの作成**

```
rails generate migration AddAgeToUsers age:integer

```

### **マイグレーションの実行**

```
rails db:migrate

```

---

## **8. RailsとJSフレームワーク**

### **RailsのViewをJSで置き換える方法**

| 方法 | Railsの役割 | JSフレームワークの役割 |
| --- | --- | --- |
| **ERB + Vue/React** | RailsのViewを使いつつ一部JS | 特定のコンポーネントのみJSで動的処理 |
| **Rails API + Vue/Nuxt/React/Next** | RailsはAPIのみ（JSON） | フルフロントエンド |
| **Rails + Hotwire** | ほぼRailsのView | JSを最小限に |

### **RailsをAPIモードで使う**

```
rails new myapp --api

```

---

## **9. まとめ**

- **MVCの役割を理解し、それぞれ適切な処理を記述**
- **モデル（M）にバリデーションとビジネスロジックを実装**
- **Railsは「設定より規約（Convention over Configuration）」を採用**
- **APIモードでVue/Nuxt/React/Nextと組み合わせることも可能**
- **マイグレーションでDBの構造を管理し、バリデーションを追加**