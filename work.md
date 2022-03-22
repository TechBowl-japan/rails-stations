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
