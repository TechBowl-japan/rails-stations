# 環境構築

1. Docker
2. Visual Studio Code
3. Git

上記は必ずインストールした上で始めてください。

## Mac における環境構築

[MacOS における環境構築について](./docs/README-mac.md) を参照ください。

## Windows における環境構築

[Windows における環境構築について](./docs/README-windows.md) を参照ください。

# テスト実行の仕方

必ず上記の環境構築にて、Rails Railway に取り組むための環境を整えてください。

Visual Studio Code を使用してコードを編集し、「TechTrain Railway」という拡張機能から「できた!」と書かれた青いボタンをクリックすると判定が始まります。

詳細にテストを実施したい場合は、下記コマンドの Station 番号を変更し、実行します。

```bash
# Station1のテストをする場合
docker compose exec web bundle exec rspec ./spec/station01
```

## 自分のリポジトリの状態を最新の TechBowl-japan/rails-stations と合わせる

Fork したリポジトリは、Fork 元のリポジトリの状態を自動的に反映してくれません。
Station の問題やエラーの修正などがなされておらず、自分で更新をする必要があります。
何かエラーが出た、または運営から親リポジトリを更新してくださいと伝えられた際には、こちらを試してみてください。

### 準備

```shell
# こちらは、自分でクローンした[GitHubユーザー名]/rails-stationsの作業ディレクトリを前提としてコマンドを用意しています。
# 自分が何か変更した内容があれば、 stash した後に実行してください。
git remote add upstream git@github.com:TechBowl-japan/rails-stations.git
git fetch upstream
```

これらのコマンドを実行後にうまくいっていれば、次のような表示が含まれています。

```shell
git branch -a ←このコマンドを実行

* master
  remotes/origin/HEAD -> origin/main
  remotes/origin/main
  remotes/upstream/main ←こちらのような upstream という文字が含まれた表示の行があれば成功です。
```

こちらで自分のリポジトリを TechBowl-japan/rails-stations の最新の状態と合わせるための準備は終了です。

### 自分のリポジトリの状態を最新に更新

```shell
# 自分の変更の状態を stash した上で次のコマンドを実行してください。

# ↓main ブランチに移動するコマンド
git checkout main

# ↓ TechBowl-japan/rails-stations の最新の状態をオンラインから取得
git fetch upstream

# ↓ 最新の状態を自分のリポジトリに入れてローカルの状態も最新へ
git merge upstream/main
git push
yarn install
```
