# 初期設定
[ユーザーマニュアル](https://docs.google.com/presentation/d/1x5-ZTntDDwKZOFPTJVHK13yDmrPWimg9R3nX5zwjUFw/edit?usp=sharing)

## bundle install エラー「Errno::EACCES: Permission denied @ rb_sysopen -」の権限視点からの対応策 (mysql2)
https://qiita.com/4EAE_Learner/items/1e0824a71cb4eb41780a

## macOS Monterey and mysql2 gem
https://medium.com/@dieter.s/macos-monterey-and-mysql2-gem-7301ce99d45f

#### パッケージのインストール

クローンしたばかりのリポジトリは歯抜けの状態なので、必要なファイルをダウンロードする必要があります。
10 分程度掛かることもあるため、気長に待ちましょう。上から順番に**１つずつ**コマンドを実行しましょう：

```powershell
cd rails-stations
```

```powershell
docker compose build
docker compose run --rm web bundle install
docker compose up -d
docker compose exec web rails db:create
docker compose exec web rails db:migrate
docker compose exec web yarn install
```

上記のコマンドを実行すると、techtrainにログインするように表示が行われます。
GitHubでサインアップしており、パスワードがない方がいましたら、そのかたはパスワードを再発行することでパスワードを作成してください。

ログインが完了すれば、ひとまず事前準備はおしまいです。お疲れ様でした。
TechTrainの画面からチャレンジを始めることもお忘れなく！
Rails Railway に取り組み始めてください。
