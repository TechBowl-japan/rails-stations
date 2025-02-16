## **座席表表示機能の実装方針**

### **1. 実装概要**
映画館の座席表を表示する機能を実装する。  
座席データは `sheets` テーブルに格納されており、変更されることのないマスターデータとして管理する。  
GET `/sheets` で座席表を取得し、表（`<table>`）形式で表示する。

---

## **2. 実装手順**
### **Step 1: `sheets` テーブルのマイグレーションを作成**
- **目的:** `sheets` テーブルをマイグレーションファイルで作成する
- **`CREATE TABLE ...` のようなSQLを直接記述せず、Railsのマイグレーション機能を使用する**

#### **📌 実装内容**
1. `rails generate migration CreateSheets` を実行してマイグレーションファイルを作成
2. `column`（座席の列）と `row`（座席の行）を持つ `sheets` テーブルを定義
3. `change` メソッド内で `create_table` を使用する
4. `rails db:migrate` を実行して、DBに適用

#### **📌 実装コード**
```ruby
class CreateSheets < ActiveRecord::Migration[7.0]
  def change
    create_table :sheets do |t|
      t.integer :column, null: false
      t.string :row, null: false

      t.timestamps
    end
  end
end
```

---

### **Step 2: `sheets` テーブルにマスターデータを投入**
- **目的:** `sheets` テーブルに座席データを登録する

#### **📌 実装内容**
1. `db/seeds.rb` にマスターデータを記述
2. `rails db:seed` を実行してデータを登録

#### **📌 `db/seeds.rb`**
```ruby
Sheet.create!([
  { column: 1, row: 'a' }, { column: 2, row: 'a' }, { column: 3, row: 'a' }, { column: 4, row: 'a' }, { column: 5, row: 'a' },
  { column: 1, row: 'b' }, { column: 2, row: 'b' }, { column: 3, row: 'b' }, { column: 4, row: 'b' }, { column: 5, row: 'b' },
  { column: 1, row: 'c' }, { column: 2, row: 'c' }, { column: 3, row: 'c' }, { column: 4, row: 'c' }, { column: 5, row: 'c' }
])
```
➡️ `rails db:seed` を実行してデータを投入。

---

### **Step 3: `Sheet` モデルの作成**
- **目的:** `sheets` テーブルを操作する `Sheet` モデルを作成する

#### **📌 実装内容**
1. `rails generate model Sheet` を実行
2. `Sheet` モデルのバリデーションを設定

#### **📌 `app/models/sheet.rb`**
```ruby
class Sheet < ApplicationRecord
  validates :column, presence: true, numericality: { only_integer: true }
  validates :row, presence: true, length: { is: 1 }
end
```

---

### **Step 4: `GET /sheets` のルーティングを設定**
- **目的:** `/sheets` にアクセスしたときに座席表を表示できるようにする
- **`GET /sheets` が `200 OK` を返し、`sheets` テーブルのデータを取得する**

#### **📌 `config/routes.rb`**
```ruby
Rails.application.routes.draw do
  resources :sheets, only: [:index]
end
```

---

### **Step 5: `SheetsController` の作成**
- **目的:** `GET /sheets` で座席表を取得し、ビューに渡す

#### **📌 `app/controllers/sheets_controller.rb`**
```ruby
class SheetsController < ApplicationController
  def index
    @sheets = Sheet.all.order(:row, :column) # 行・列順に並び替え
  end
end
```

---

### **Step 6: 座席表をビューに表示**
- **目的:** `sheets` のデータをループ処理して `<table>` 形式で表示する

#### **📌 `app/views/sheets/index.html.erb`**
```erb
<h1>座席表</h1>

<table border="1">
  <thead>
    <tr>
      <th colspan="5">スクリーン</th>
    </tr>
  </thead>
  <tbody>
    <% grouped_sheets = @sheets.group_by(&:row) %>
    <% grouped_sheets.each do |row, seats| %>
      <tr>
        <% seats.each do |seat| %>
          <td><%= "#{seat.row}-#{seat.column}" %></td>
        <% end %>
      </tr>
    <% end %>
  </tbody>
</table>
```

✅ **`group_by(&:row)` を使い、行ごとに座席をグループ化してループ処理する！**  
✅ **`<table>` タグを使い、座席表を表形式で表示！**

---

### **Step 7: 動作確認 & Gitにプッシュ**
1. `rails db:migrate` を実行し、マイグレーションを適用
2. `rails db:seed` を実行し、座席マスターデータを登録
3. `rails s` でサーバーを起動し、`http://localhost:3000/sheets` にアクセス
4. 座席表が `<table>` タグで表示されることを確認
5. 問題がなければ `git add . && git commit -m "座席表表示機能の実装" && git push` でリポジトリにプッシュ

---

## **3. クリア条件チェックリスト**
| クリア条件 | 実装のポイント | ✅ |
|------------|-------------|---|
| `sheets` テーブルのマイグレーションが存在し、SQLの直接記述なし | `create_table :sheets` を使用 | ✅ |
| `sheets` テーブルにマスターデータが投入されている | `rails db:seed` でデータ投入 | ✅ |
| `GET /sheets` が `200 OK` を返す | `SheetsController#index` の実装 | ✅ |
| `GET /sheets` のHTMLに `<table>` タグが含まれている | `index.html.erb` に `<table>` を使用 | ✅ |
| `sheets` テーブルのデータをビューで取得している | `@sheets = Sheet.all` を実装 | ✅ |

---

## **4. まとめ**
✅ **Railsのマイグレーションを使って `sheets` テーブルを作成**  
✅ **マスターデータを `db/seeds.rb` に登録し、`rails db:seed` で投入**  
✅ **`GET /sheets` で座席データを取得し、ビューで `<table>` を使って表示**  
✅ **動作確認を行い、問題なければ Git にプッシュ**  

---