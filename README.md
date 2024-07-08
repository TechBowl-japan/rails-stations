# 環境構築

## 概要

TechTrain Railway の問題を解くために必要な下記ツールのインストール方法と環境構築の手順を解説します。

- Docker
- Visual Studio Code
- Git

## 手順

1. Docker Desktop のインストール
   - 自身の Mac に搭載されている CPU を確認し、[Install Docker Desktop on Mac](https://docs.docker.com/desktop/install/mac-install/) から Docker Desktop をダウンロードし、インストールします。
   - Docker Desktop をインストールした後、一度 PC を再起動してから Docker Desktop を起動してください。
   - これにより、Docker が正しく動作するか確認できます。
2. Visual Studio Code のインストール
   - [Visual Studio Code](https://code.visualstudio.com/) から自分の OS に適した Visual Studio Code をダウンロードします。
     ![Visual Studio Codeをインストール](./images/install-vscode.gif)
3. Visual Studio Code に TechTrain Railway のクリア条件を判定するツールをインストール
   - Visual Studio Code を開き、拡張機能（Extensions）から「TechTrain Railway」という拡張機能を検索してインストールします。これにより、Railway のクリア条件を簡単に判定できるようになります。
     ![TechTrain Railwayの拡張機能をインストール](./images/install-extensions.gif)
4. GitHub リポジトリのフォークとダウンロード
   1. GitHub リポジトリのフォーク
      - [TechBowl-japan/rails-stations | GitHub](https://github.com/TechBowl-japan/rails-stations) にアクセスし、右上の"Fork"ボタンをクリックして、リポジトリを自分の GitHub アカウントにフォークします。  
        ![GitHubリポジトリのフォーク](./images/fork-repository.gif)
   2. Git のインストール
      - GitHub からリポジトリをクローンするためには、Git が必要です。
      - インストールされていない場合は、[Git の公式サイト](https://git-scm.com/download/mac) で提示された選択肢から 1 つ選び、ダウンロードします。
   3. GitHub リポジトリのダウンロード
      - フォークが完了したら、自分の GitHub アカウント上でフォークされたリポジトリを選択し、"Code"ボタンをクリックして、リポジトリの URL をコピーします。
      - そして、ターミナルを開いて以下のコマンドを実行してリポジトリをダウンロードします。
      ```bash
      git clone https://github.com/{{あなたのGitHubID}}/rails-stations.git
      ```
5. Visual Studio Code でダウンロードしたリポジトリを開く
   - リポジトリをダウンロードしたディレクトリで右クリックし、"Open with Code"または"Visual Studio Code で開く"を選択します。
   - または、コマンドラインで以下のコマンドを実行して、リポジトリのディレクトリを Visual Studio Code で開きます。
   ```bash
   code ダウンロードしたリポジトリのディレクトリ
   ```
   - Visual Studio Code が起動したら、左上のファイル -> フォルダを開くを選択して、ダウンロードしたリポジトリのディレクトリを選択します。
6. Docker コマンドでコンテナを起動、パッケージのインストール
   - ターミナルでリポジトリのディレクトリに移動し、以下のコマンドを実行して Docker コンテナを起動します。
   ```bash
   docker compose build
   docker compose run --rm web bundle install
   docker compose up -d
   docker compose exec web rails db:create
   docker compose exec web rails db:migrate
   docker compose exec web yarn install // ←こちらを実行した後に「TechTrainにログインします。GitHubでサインアップした方はお手数ですが、パスワードリセットよりパスワードを発行してください」と出てくるため、ログインを実行してください。出てこない場合は、コマンドの実行に失敗している可能性があるため、TechTrainの問い合わせかRailwayのSlackより問い合わせをお願いいたします。
   ```
   ※ Docker コンテナのビルドおよび起動には時間がかかる場合があります。コマンドが正常に完了するまで待ってください。
7. Docker コマンドでコンテナの起動を確認
   - 以下のコマンドを実行し、手順 6.で起動した Docker コンテナのプロセスが起動しているかを確認してください。
   ```bash
   docker compose ps
   ```
   ※ Docker が使用するポートが他のアプリケーションと競合していないか確認してください。
8. ローカルサーバが立ち上がっていることを確認
   - [http://localhost:3000](http://localhost:3000) にアクセスし、ローカルサーバが立ち上がっていることを確認します。
9. 環境構築完了後の確認
   - 環境構築が正常に終了したことを確認するために、Visual Studio Code でリポジトリを開いてから、ファイルの変更や追加ができるか確認してください。
   - また、TechTrain Railway の拡張機能が正しく機能しているかも確認してください。

---

以上で Rails Railway に取り組むための環境が整いました。  
Visual Studio Code を使用してコードを編集し、「TechTrain Railway」という拡張機能から「できた!」と書かれた青いボタンをクリックすると判定が始まります。
