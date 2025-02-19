# **Rubyにおけるnilとからの配列[]の違い**

## **1. 基本的な違い**

### **nil**
- 「何もない」「未定義」を表す特別な値
- `NilClass`のインスタンス
- `false`や`0`とは異なる
- メソッドを呼び出すと`NoMethodError`が発生する可能性がある

### **[]（空の配列）**
- 要素が0個の配列
- `Array`クラスのインスタンス
- 配列のメソッドが全て使える
- イテレーション（each等）が可能（0回実行）

## **2. 動作の違い**

### **メソッド呼び出し**
```ruby
# nilの場合
nil.length     # => NoMethodError
nil.each       # => NoMethodError

# 空配列の場合
[].length      # => 0
[].each        # => 正常に動作（0回実行）
```

### **条件分岐での評価**
```ruby
# nilの場合
if nil         # => false
if nil.present?  # => false
if nil.blank?    # => true

# 空配列の場合
if []          # => true
if [].present?   # => false
if [].blank?     # => true
```

## **3. 一般的な使用場面**

### **nilを使う場合**
- 値が存在しないことを明示的に示したい時
- データベースでNULLを表現する時
- オプショナルな値を扱う時

### **[]を使う場合**
- コレクションが空であることを表現する時
- イテレーション処理を安全に行いたい時
- 配列メソッドを使用する可能性がある時

## **4. コード例**

### **コントローラーでの使用例**
```ruby
# nilを使用
def show
  @schedules = @movie.is_showing ? @movie.schedules.order(:start_time) : nil
end

# 空配列を使用
def show
  @schedules = @movie.is_showing ? @movie.schedules.order(:start_time) : []
end
```

### **ビューでの使用例**
```erb
# nilの場合
<% if @schedules.present? %>
  <% @schedules.each do |schedule| %>
    <%= schedule.start_time %>
  <% end %>
<% end %>

# 空配列の場合
<% @schedules.each do |schedule| %>  # nilチェック不要
  <%= schedule.start_time %>
<% end %>
```

## **5. 推奨される使い方**

### **nilを使う場合**
- 値の不在を明示的に示したい時
- データベースのNULL値を扱う時
- オプショナルなパラメータを扱う時

### **[]を使う場合**
- コレクションを扱う時
- イテレーションを行う時
- エラーを防ぎたい時（より安全）

## **6. 結論**
- 基本的にコレクションを扱う場合は`[]`を使用する
- 値の存在/不在を明確に示したい場合は`nil`を使用する
- エラーを防ぎたい場合は`[]`を選択する