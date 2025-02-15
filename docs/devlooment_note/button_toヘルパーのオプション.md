## **button_toヘルパーのオプション解説**

```ruby
<%= button_to '削除',  # ボタンのテキスト
    admin_movie_path(@movie),  # リクエスト先のURL
    method: :delete,  # HTTPメソッド
    data: { turbo_confirm: "..." },  # 確認ダイアログ
    class: 'delete-button'     # CSSクラス
%>
```

### 1. `method: :delete`
- **これは何か？**
  - ボタン押下時に送信されるHTTPメソッドを指定
  - デフォルトでは`POST`メソッド
  
- **どこで定義？**
  - Rails標準の機能として用意されている
  - フォーム要素として実装される

- **実際の動作**
  - ボタン押下時にフォームがサブミット
  - `DELETE`リクエストをサーバーに送信

### 2. `data: { turbo_confirm: "..." }`
- **これは何か？**
  - Turboによる確認ダイアログを表示するための指定
  - Rails 7からは`turbo_confirm`を使用
  
- **どこで定義？**
  - Turboの機能として用意されている
  - `data-turbo-confirm`属性として出力される

- **実際の動作**
  - ボタン押下時に確認ダイアログを表示
  - OKを押すとリクエストが送信される
  - キャンセルを押すとリクエストが中止される

### 3. `class: 'delete-button'`
- **これは何か？**
  - HTMLの`class`属性を指定
  - CSSでスタイリングするために使用

### 実際に生成されるHTML
```html
<form class="button_to" method="post" action="/admin/movies/1">
  <input type="hidden" name="_method" value="delete">
  <button class="delete-button" 
          data-turbo-confirm="映画「タイトル」を削除してもよろしいですか？" 
          type="submit">削除</button>
  <input type="hidden" name="authenticity_token" value="...">
</form>
```

### link_toとの主な違い
1. **HTMLの構造**
   - `button_to`はフォーム要素として実装
   - `link_to`はアンカー要素として実装

2. **JavaScriptの依存**
   - `button_to`は標準的なフォーム送信を使用
   - `link_to`はJavaScriptによるリクエスト処理が必要

3. **デフォルトのHTTPメソッド**
   - `button_to`は`POST`
   - `link_to`は`GET`

### メリット
1. **セキュリティ**
   - CSRFトークンが自動的に含まれる
     - 詳細は[こちら](./CSRFトークン.md)
   - 不正なリクエストを防止

2. **UX（ユーザー体験）**
   - 確認ダイアログによる誤操作防止
   - ネイティブのフォーム送信による信頼性

3. **アクセシビリティ**
   - セマンティックなHTML構造
   - スクリーンリーダーとの親和性が高い

4. **JavaScriptの依存度**
   - JavaScriptが無効でも動作
   - より堅牢な実装が可能