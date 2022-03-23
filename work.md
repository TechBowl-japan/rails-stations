Railway 以前に、Dockerコンテナ上の開発が初めてだったので、使い方戸惑い調べたこと
ただ、開発環境のセットアップに手こずらなかったのは感動　→　勉強しよう

Docker関連　参照記事
[Docker for Macのインストール後に、エラーが発生してコンテナが立ち上がらない時の対処法](https://www.konosumi.net/entry/2018/01/21/125523)

[docker-composeとGitを利用したWebシステム開発の効率化](https://qiita.com/smiler5617/items/320b3e8d2390c16ac747)
[【Docker】Ruby on Railsのコンテナを作成して起動するまで。](http://www.code-magagine.com/?p=8808)
[はじめてのGit Hub①（Docker環境構築をアップ）](https://laraweb.net/environment/6516/)
[【Docker】コンテナ内のデータベース閲覧(ローカル,EC2)](https://qiita.com/go_glzgo/items/3520818659a07bd17839)
[Dockerで開発環境使ったら、Railsコマンドが使えなくなった罠を解決](https://qiita.com/TeppeiMimachi/items/9ef7b563181f81e42561)
[【Rails】dockerでrailsコンソールを使う方法](https://qiita.com/shizen-shin/items/44b04c8d46d972e15bf7)

MySQL
[MySQLでよく見かけるエラーの発生原因と対策方法](https://proengineer.internous.co.jp/content/columnfeature/7054#section206)
[DockerのMySQL接続でテーブル確認する際、ERROR 1046 (3D000): No database selectedが出た時の対処法](https://qiita.com/Oyuki123/items/d14e937115c82a71f8f7)
[MySQLのバージョン確認方法](https://qiita.com/rokumura7/items/b270acb9550efddd5fe5)


Railway 1
【仕様】
- `GET /movies` で映画一覧のページを返す
　- レスポンスはJSONではなくHTML
　- moviesテーブルにある要素を絞り込みせずすべて表示する
　- 映画のタイトル・画像を表示する

# 作業ログ
モデル、コントローラ、ビューなどないことを確認したので、生成するところからスタート

Movieモデル　の生成

Moviesコントローラの生成
`$ docker-compose run web rails g controller movies`

コントローラのindexアクションへテストHTMLを追加し、正常にルーティングされることを確認
DBとの接続確認をして、表示されれば、ビューの作成〜

データの取り出しも完了

Railway1 はクリア

参照記事

(Ruby on Railsで簡単なアプリを作成)[https://qiita.com/d0ne1s/items/5e63dde992f20f25b8bb]
(【Rails】画像の表示方法)[https://qiita.com/hacchi56/items/b2cc210ed3978fe0b126]
(【RubyonRails完全入門】開発の流れを超初心者向けに解説)[https://www.sejuku.net/blog/96900]
(Rubyでuninitialized constantエラーを解消する方法を現役エンジニアが解説【初心者向け】)[https://techacademy.jp/magazine/43826]
(マイグレーションファイルやテーブルの削除手順書)[https://qiita.com/tanayasu1228/items/e7270d71af4fdb18b241]
(新しいマイグレーションを追加してテーブルを変更)[https://www.javadrive.jp/rails/model/index7.html]
(rails generateで自動生成されるファイルの設定)[https://qiita.com/kodai_0122/items/14494a3848654f32909d]
[[Rails]マイグレーションファイルについて勉強してみた！(テーブルへのカラム追加)](https://qiita.com/jackie0922youhei/items/09a7b081e40506f07358)
[間違えて行ったmigrateを取り消す方法](https://qiita.com/y-136/items/3b8e3334ab2a26d84b77)
[railsのmigration状況を確認する](https://xengineer.hatenablog.com/entry/2015/06/06/rails%E3%81%AEmigration%E7%8A%B6%E6%B3%81%E3%82%92%E7%A2%BA%E8%AA%8D%E3%81%99%E3%82%8B)
(Rails テーブルのデータ型について)[https://qiita.com/s_tatsuki/items/900d662a905c7e36b3d4]
(間違えて行ったmigrateを取り消す方法)[https://qiita.com/y-136/items/3b8e3334ab2a26d84b77]
(【Rails】マイグレーションファイルの削除)[https://qiita.com/ISSO33/items/33a935cb3255c269bef2]
(コントローラとアクションの作成とルーティングの設定)[https://www.javadrive.jp/rails/ini/index4.html]
(Railsコンソールを使ってレコード追加する方法)[https://qiita.com/okamoto_ryo/items/5aa0c54a1ac0e646e51f]

まだまだRailsで開発が染み付いていないので、色々とググりながら調べました。
マイグレーションファイルにいらんことしたので、そのせいでちょっと時間取られた


【仕様】
- `GET /admin/movies` で現在登録されているmoviesの内容をすべて出力する → リンク遷移OK
- レスポンスはJSONではなくHTML →　問題なし

DBのデータ取得は完了残りはビューの問題なので実装する
- tableタグを利用して表形式で表示する 
- 絞り込みせず全件出力する
- 各カラムを出力する
- 画面上ではカラム名を使わず下記の文言で表記する
- image_urlは"画像"というリンクテキストでリンク先を画像のURLにする
- is_showingはtrueのとき上映中、falseのとき上映予定と表記する

【カラムと画面上の表記の対応】
- id: ID
- name: タイトル
- year: 公開年
- description: 概要
- image_url: 画像URL
- is_showing: 上映中
- created_at: 登録日時
- updated_at: 更新日時

参照記事
[【初心者向け】管理者ユーザーと管理者用controllerの追加方法[Ruby, Rails]](https://qiita.com/tanutanu/items/7ce8826615f1af605164)

作業ログ
以下のコマンドを実行して、Controllerを追加
$ docker-compose run web rails g controller admin::movies

ルーティングを確認して、リンク先が正しいこと確認
$ docker-compose run web rails routes 
一旦、DBのデータをadmin/moviesのビューへ表示できるかをテスト

→　期待挙動通り遷移
