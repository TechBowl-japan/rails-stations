## **ERBのループ処理の実装方法**

### **概要**

ERB（Embedded Ruby）は、HTML内でRubyのコードを実行できるテンプレートエンジンです。 `each` ループを使用すると、**配列やデータを繰り返し処理して、ビューに動的に表示** できます。

### **基本的な **``** の使い方**

```erb
<% @movies.each do |movie| %>
  <p><%= movie.name %>（<%= movie.year %>年）</p>
<% end %>
```

➡️ `@movies` の配列をループして、映画のタイトルと公開年を表示する。

### **座席表の表示に応用する**

#### **1. テーブルタグを使用した座席表の作成**

```erb
<table border="1">
  <thead>
    <tr>
      <th colspan="5">スクリーン</th>
    </tr>
  </thead>
  <tbody>
    <% @sheets.group_by(&:row).each do |row, seats| %>
      <tr>
        <% seats.each do |seat| %>
          <td><%= "#{seat.row}-#{seat.column}" %></td>
        <% end %>
      </tr>
    <% end %>
  </tbody>
</table>
```

➡️ ``** を使って行ごとに座席をグループ化し、**``** でループして表示** する。

✅ **ERBのループ処理のポイント**

- **データ配列を **``** でループすることで、動的にHTMLを生成できる**
- ``** を使うことで、特定のルールに従ってグループ化が可能**
- ``** タグを組み合わせることで、整った座席表を作成できる**

---

## **3. **``** メソッドとは？（データのグループ化）**

### **概要**

`group_by` メソッドは、**指定したキーごとにデータを分類・グループ化するメソッド** です。 特に「カテゴリごと」「日付ごと」「座席の行ごと」などにデータをまとめたい場合に役立ちます。

### **基本的な使い方**

```ruby
movies = [
  { title: "インセプション", genre: "SF" },
  { title: "ダークナイト", genre: "アクション" },
  { title: "TENET", genre: "SF" }
]

movies_by_genre = movies.group_by { |movie| movie[:genre] }
```

➡️ このコードを実行すると、`genre` ごとにデータが分類される。

```ruby
{
  "SF" => [{ title: "インセプション", genre: "SF" }, { title: "TENET", genre: "SF" }],
  "アクション" => [{ title: "ダークナイト", genre: "アクション" }]
}
```

### **ERBで **``** を活用する例**

```erb
<% @sheets.group_by(&:row).each do |row, seats| %>
  <tr>
    <% seats.each do |seat| %>
      <td><%= "#{seat.row}-#{seat.column}" %></td>
    <% end %>
  </tr>
<% end %>
```

➡️ **座席表を「行ごと」にまとめて表示する** ことが可能になる。

✅ ``** のメリット**

- **データをカテゴリごとに整理できる**
- **テーブルやリストの出力時に、グループ単位で表示できる**
- **ERB内でも活用できるので、ビューの実装が簡単になる**


