## STATION2｜実装方針

### ポイント
- 管理画面と通常画面を適切に分離すること！
- データとビジネスロジック（model）は共通でOK
- 制御ロジック（Controller:）は一般ユーザー向け機能と管理者向け機能は目的が異なるため別にする
  - 疑問：部分的に同一の機能を持つ場合はどう考えたらいい？
- 表示（View）はもちろん別になる
- rootingを追加する



### ディレクトリ構造
```
app/
├── controllers/
│   ├── admin/
│   │   └── movies_controller.rb  # 新規作成
│   └── movies_controller.rb      # 既存
├── views/
│   ├── admin/
│   │   └── movies/
│   │       └── index.html.erb    # 新規作成
│   └── movies/
│       └── index.html.erb        # 既存
└── models/
    └── movie.rb                  # 既存を使用
 ```
 