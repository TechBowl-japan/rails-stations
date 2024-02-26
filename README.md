# TechTrain Rails Railway について

Railway では VSCode の拡張機能を使ってクリア判定を行います。この際、Station の内容に即した実装になっているかを最低限のラインとして確認します。
テストが通れば Station クリアとなります。
クリア後、TechTrain の画面に戻り、クリアになっているかを確認してみてください。
※テスト(Rspec)を書くことはクリア判定がうまく機能しないことがあるのでお控えください。

## バージョン情報

| 言語、フレームワークなど | バージョン |
| :----------------------: | :--------: |
|          Rails           |    6.\*    |
|           Ruby           |   3.2.\*   |
|          MySQL           |    8.\*    |

## 初期設定

[ユーザーマニュアル](https://docs.google.com/presentation/d/1x5-ZTntDDwKZOFPTJVHK13yDmrPWimg9R3nX5zwjUFw/edit?usp=sharing)

### 必要なツール

|    ツール名    |      目安となるバージョン       |
| :------------: | :-----------------------------: |
|    Node.js     | 18.\_ [ 16.\* では動作しません] |
|      Yarn      |             1.22.\*             |
|     Docker     |             24.0.\*             |
| Docker Compose |             2.23.\*             |

Docker をお使いの PC にインストールしてください。
バージョンが異なる場合、動作しない場合があります。
Node.js, Yarn のインストールがまだの場合は[html-staions](https://github.com/TechBowl-japan/html-stations)を参考にインストールしてください。  
また、使用 PC が Windows の場合は、WSL を[この記事](https://learn.microsoft.com/ja-jp/windows/wsl/install)を参考にインストールしてください。

### 「必要なツール」インストール済みの場合

次の手順で取り組み始めてください。

#### `rails-stations`リポジトリの Fork

画面右上にある Fork より [Rails Railway](https://github.com/TechBowl-japan/rails-stations)のリポジトリを自分のアカウントに Fork してください。

#### `rails-stations`リポジトリのクローン

作成したリポジトリを作業するディレクトリにクローンしましょう。

- Mac なら Terminal.app(iTerm2 などでも良い)
- Windows なら PowerShell(GitBash などのインストールしたアプリでもう良いです。アプリによってはコマンドが異なることがあります)

で作業するディレクトリを開き、次のコマンドで Fork した React.js 　 Railway のリポジトリをローカルにクローンしてください。

```powershell
git clone https://github.com/{GitHubのユーザー名}/rails-stations.git
```

SSH でクローンを行う場合には、次のようになります

```
git clone git@github.com:[GitHubのユーザー名]/rails-stations.git
```

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
docker compose exec web yarn install // ←こちらを実行した後に「TechTrainにログインします。GitHubでサインアップした方はお手数ですが、パスワードリセットよりパスワードを発行してください」と出てくるため、ログインを実行してください。出てこない場合は、コマンドの実行に失敗している可能性があるため、TechTrainの問い合わせかRailwayのSlackより問い合わせをお願いいたします。
docker compose exec web yarn build
```

上記のコマンドを実行すると、techtrain にログインするように表示が行われます。
GitHub でサインアップしており、パスワードがない方がいましたら、そのかたはパスワードを再発行することでパスワードを作成してください。

ログインが完了すれば、ひとまず事前準備はおしまいです。お疲れ様でした。
TechTrain の画面からチャレンジを始めることもお忘れなく！
Rails Railway に取り組み始めてください。

## DB と接続をしたいという方へ

- Sequel Pro
- Sequel Ace
- Table Plus
- MySQL Workbench

などで DB の中身を確認したいという方は次の接続情報を利用してください

|   項目名    |      情報       | 説明                                                                                                                                                    |
| :---------: | :-------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------ |
|    Host     |    127.0.0.1    | 接続先の DB が存在するホストを指します。                                                                                                                |
|    Port     |      3306       | DB 接続に利用するポート番号です。                                                                                                                       |
|   DB User   |      root       | DB 内のユーザーになります。他のユーザーも用意してあるので、勉強に使いたい時は使ってみてください。                                                       |
| DB Password |    password     | DB に接続する際のパスワードです。root 用のパスワードなので、他のユーザーを利用したい場合には、Docker まわりの内容を勉強し、設定を確認してみてください。 |
|   DB Name   | app_development | 接続する DB 名です。他に app_test という Rails のテストをする際に利用する DB を用意しています。                                                         |

SSH という仕組みを利用して繋ぐこともできますが、基本的には上記の設定で繋ぐのが一番簡単です。
接続されないという方は、Docker のビルドと起動がされていないかもしれません。
解決についての詳細は、この README にある[DB に接続して中身を見たいです](#DBに接続して中身を見たいです)をご参照ください。

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

## よくある質問

### （GitHub アカウントでサインアップしたので）パスワードがわかりません

https://techtrain.dev/resetpassword

上記の URL より自分の登録したメールアドレスより、パスワードリセットを行うことで、パスワードを発行してください。

メールアドレスがわからない場合は、ログイン後にユーザー情報の編集画面で確認してください。
ログインしていれば、次の URL から確認できます。

https://techtrain.dev/mypage/profile

### DB に接続して中身を見たいです

以下の 2 点を確認してみてください。

#### Docker が起動されているかを確かめる

Mac なら, iTerm.app, Terminal.app
Windows なら, PowerShell

などのアプリケーションを立ち上げ、このリポジトリが存在するディレクトリに移動してください。
わからない方は、 `カレントディレクトリ 移動` などで調べてみてください。(Mac なら、cd コマンド、Windows なら一部 dir コマンドを利用します)
このリポジトリを Clone したディレクトリがカレントディレクトリになるように移動してください。
その上で `docker compose ps` を実行して次のように Docker が起動されていることを確認してください。

```shell
$ docker compose ps

        Name                      Command               State                          Ports
-------------------------------------------------------------------------------------------------------------------
rails-stations_db_1    docker-entrypoint.sh --def ...   Up      0.0.0.0:3306->3306/tcp,:::3306->3306/tcp, 33060/tcp
rails-stations_web_1   entrypoint.sh bash -c rm - ...   Up      0.0.0.0:3000->3000/tcp,:::3000->3000/tcp
```

`Exit` という文字が見えたのであれば、何らかの原因で Docker の起動がうまく動作していません。
`docker compose logs` コマンドを起動してその内容をコピペし、 Railway の Slack ワークスペースに入ってみてください。
そちらで質問すると、回答があるかもしれません。自分で調べられるのがベストです。

#### Docker が起動されているが、接続されない

Exit がない状態にも関わらず、接続できない場合は、Database の作成がうまくいっていない可能性があります。
次のコマンドで動作するかどうかを確認してみてください。

```
docker compose exec db mysql -uroot -ppassword -e 'show databases;';
```

次のような結果が返ってきていれば、正常です。

```
docker compose exec db mysql -uroot -ppassword -e 'show databases;'
mysql: [Warning] Using a password on the command line interface can be insecure.
+--------------------+
| Database           |
+--------------------+
| app_development    |
| app_test           |
| information_schema |
| message            |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
```

### commit したのにチェックが実行されていないようです

チェックのためには、次の二つの条件が必須となります。

1. 黒い画面（CLI,コマンドライン）から TechTrain へのログイン
2. pre-commit hook と呼ばれる commit 時に実行される Git の仕組みが仕込まれていること

特に 2 については

- SourceTree や GitHubApp でクローンした
- https でクローンした

際にうまくいかないことが多いということが報告されています。
もし上記のようなことが起こった場合には、Terminal などの画面で SSH によるクローンを試していただき、その上で `yarn install` を実行していただくことで解決することが多いです。もし解決しなかった場合には、運営までお問い合わせいただくか、Railway の Slack ワークスペースにてご質問ください。

### commit しないでテストを実行したいです

以下のようなコマンドを実行すると stationXX（01〜13 の 2 桁の数字が入ります）のテストだけを実行できます。
エラーメッセージもより詳細に出力されるため、なぜエラーが出ているかわからない人はこちらで実行するのをおすすめします。

```shell
docker compose exec web rspec spec/stationXX
```

また、以下のようなエラーが出力されている際にはクラス名などが定義されていないか運営による不具合の可能性があるため、一度上のコマンドを実行し Rspec としてエラーを出力してどちらに当たるか判断していただくようお願いいたします。

```bash
× エラー：有効なテストが存在しません．
error Command failed with exit code 1.
info Visit https://yarnpkg.com/en/docs/cli/run for documentation about this command.
```

### Windows で Container が立ち上がらない

WSL のインストールが済んでいて、build は成功するが以下のようなエラーが出力される場合には改行コードが CRLF になっている可能性があります。

```bash
standard_init_linux.go:228: exec user process caused: no such file or directory
```

その場合には、`git clone`で改行コードが LF を CRLF に変換しないようにする必要があります。
そのため、自動変換をしないようにして再度ローカルに`git clone`を再実行してください。

```bash
git config --global core.autocrlf input

git clone https://github.com/{GitHubのユーザー名}/rails-stations.git

# 再度、パッケージのインストールのコマンドを実行しなおしてください。
```
