# TechTrain Rails Railway について

Railway では Git で自分が取り組んだ内容を記録するときに、自動でテストが実行されます。この際、Station の内容に即した実装になっているかを最低限のラインとして確認します。
テストが通れば Station クリアとなります。
クリア後、TechTrain の画面に戻り、クリアになっているかを確認してみてください。

## 初期設定

### 必要なツール

1. Node.js( 14.* ) [ 12.* ,  16.* では動作しません]
2. Yarn
3. Docker
4. Docker Compose

### 「必要な」インストール済みの場合

次の手順で取り組み始めてください。

####  `rails-stations`リポジトリのFork

画面右上にあるForkより [Rails Railway](https://github.com/TechBowl-japan/rails-stations)のリポジトリを自分のアカウントにForkしてください。

#### `rails-stations`リポジトリのクローン

作成したリポジトリを作業するディレクトリにクローンしましょう。

* Macなら Terminal.app(iTerm2などでも良い)
* Windowsなら PowerShell(GitBashなどのインストールしたアプリでもう良いです。アプリによってはコマンドが異なることがあります)

で作業するディレクトリを開き、次のコマンドでForkしたReact.js　Railwayのリポジトリをローカルにクローンしてください。


```powershell
git clone https://github.com/{GitHubのユーザー名}/rails-stations.git
```

SSHでクローンを行う場合には、次のようになります

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
docker compose up -d
```

上記のコマンドを実行すると、techtrainにログインするように表示が行われます。
GitHubでサインアップしており、パスワードがない方がいましたら、そのかたはパスワードを再発行することでパスワードを作成してください。

ログインが完了すれば、ひとまず事前準備はおしまいです。お疲れ様でした。
TechTrainの画面からチャレンジを始めることもお忘れなく！
Rails Railway に取り組み始めてください。


## トラブルシューティング

### commitしたのにチェックが実行されていないようなのですが？

チェックのためには、次の二つの条件が必須となります。

1. 黒い画面（CLI,コマンドライン）からTechTrainへのログイン
2. pre-commit hook と呼ばれるcommit時に実行されるGitの仕組みが仕込まれていること

特に２については

* SourceTreeやGitHubAppでクローンした
* httpsでクローンした

際によく起こる現象であることを報告されています。
もし上記のようなことが起こった場合には、Terminalなどの画面でSSHによるクローンを試していただき、その上で `yarn install` を実行していただくことで解決することが多いです。もし解決しなかった場合には、運営までお問い合わせいただくか、RailwayのSlackワークスペースにてご質問ください。

## 自分のリポジトリの状態を最新の TechBowl-japan/rails-stations と合わせる

Forkしたリポジトリは、Fork元のリポジトリの状態を自動的に反映してくれませんため、
Stationの問題やエラーの修正などがなされておらず、自分で更新をする必要があります。
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

### GitHubアカウントでサインアップしたので、パスワードがないという方へ

https://techbowl.co.jp/techtrain/resetpassword

上記のURLより自分の登録したメールアドレスより、パスワードリセットを行うことで、パスワードを発行してください。

メールアドレスがわからない場合は、ログイン後にユーザー情報の編集画面で確認してください。
ログインしていれば、次のURLから確認できます。

https://techbowl.co.jp/techtrain/mypage/profile
