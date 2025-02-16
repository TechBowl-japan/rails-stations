# **schema.rbについて**

## **1. 基本的な役割**
- データベースの現在の構造を Ruby のコードで表現
- テーブル定義、カラム定義、インデックスなどを記録
- チーム開発時のデータベース構造の共有に使用

## **2. 自動更新のタイミング**
以下の操作時に自動的に更新されます：
- `rails db:migrate` の実行時
- `rails db:schema:load` の実行時
- 新しいマイグレーションの適用時

## **3. ファイルの内容例（あなたの場合）**
```ruby
create_table "sheets", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
  t.integer "column", limit: 1, null: false    # 座席の列番号
  t.string "row", limit: 1, null: false        # 座席の行記号
  t.datetime "created_at", null: false         # 作成日時
  t.datetime "updated_at", null: false         # 更新日時
end
```

## **4. 重要なポイント**
1. **直接編集しない**
   - このファイルは自動生成される
   - 変更はマイグレーションファイルを通じて行う

2. **バージョン管理に含める**
   - GitなどのVCSに必ず含める
   - チームメンバー間でDB構造を共有するため

3. **データベース再構築に使用**
   - `rails db:schema:load` でスキーマを再現可能
   - 新しい環境セットアップ時に使用