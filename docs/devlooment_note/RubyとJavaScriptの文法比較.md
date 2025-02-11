# **RubyとJavaScriptの文法比較**

## **1. RubyとJavaScriptの共通点**
### **① 制御構文（if, while, for）**
RubyもJavaScriptも、基本的な制御構文（`if`、`while`、`for` など）は同じような考え方で動きます。

#### **if文の比較**
```ruby
# Ruby
if age >= 18
  puts "大人です"
else
  puts "未成年です"
end
```

```js
// JavaScript
if (age >= 18) {
  console.log("大人です");
} else {
  console.log("未成年です");
}
```

#### **ループ処理の比較**
```ruby
# Ruby
(1..5).each do |num|
  puts num
end
```

```js
// JavaScript
for (let num = 1; num <= 5; num++) {
  console.log(num);
}
```

どちらも **繰り返し処理** を行っていますが、**書き方の違い** があることが分かりますね。

---

### **② 関数（メソッド）の定義**
```ruby
# Ruby
def greet(name)
  return "こんにちは、#{name} さん！"
end

puts greet("太郎")  # => こんにちは、太郎 さん！
```

```js
// JavaScript
function greet(name) {
  return `こんにちは、${name} さん！`;
}

console.log(greet("太郎")); // => こんにちは、太郎 さん！
```

- **関数（メソッド）を定義して、引数を渡し、値を返すという概念は同じ**
- **`def ... end`（Ruby）と `function ... { }`（JavaScript）の違い**

---

## **2. RubyとJavaScriptの違い**
### **① ブロック構文（do ... end, { ... })**
JavaScriptでは **関数（関数式やアロー関数）を使って処理をまとめる** のが一般的ですが、  
Rubyには **ブロック（block）** という概念があり、**ブロックをメソッドの引数として渡すことができる** のが特徴です。

```ruby
# Ruby
[1, 2, 3].each do |num|
  puts num
end
```

```js
// JavaScript
[1, 2, 3].forEach(num => {
  console.log(num);
});
```

Rubyの `each` にブロックを渡す書き方は、JavaScriptの `forEach` に似ています。  
ただし、**Rubyでは「メソッドの一部」としてブロックを扱う** のが特徴です。

---

### **② オブジェクト指向の違い**
JavaScriptは **プロトタイプベース**、Rubyは **クラスベース** のオブジェクト指向です。  
クラスを定義する方法も違います。

#### **Ruby**
```ruby
class User
  def initialize(name)
    @name = name
  end

  def greet
    "こんにちは、#{@name} さん！"
  end
end

user = User.new("太郎")
puts user.greet  # => こんにちは、太郎 さん！
```

#### **JavaScript**
```js
class User {
  constructor(name) {
    this.name = name;
  }

  greet() {
    return `こんにちは、${this.name} さん！`;
  }
}

const user = new User("太郎");
console.log(user.greet()); // => こんにちは、太郎 さん！
```

どちらも **「Userクラスを作成して、インスタンスを生成し、メソッドを呼び出す」** という流れは同じです。

---

### **③ 非同期処理**
JavaScriptは **非同期処理（async/await, Promise）** を多用するのに対し、  
Rubyは基本的に **同期的に処理を実行** します。

#### **JavaScript（非同期処理）**
```js
async function fetchData() {
  let response = await fetch("https://example.com/data");
  let data = await response.json();
  console.log(data);
}
```

Rubyでは、非同期処理を行うには **スレッドや非同期ライブラリ（Sidekiqなど）** を使う必要があります。

---

## **3. ERB（Embedded Ruby）の特徴**
**ERBは、HTMLの中にRubyのコードを埋め込むためのテンプレートエンジン** です。

### **基本構文**
```erb
<h1>ユーザー一覧</h1>

<ul>
  <% @users.each do |user| %>
    <li><%= user.name %></li>
  <% end %>
</ul>
```

- `<% ... %>` → **Rubyのコードを書くが、出力はしない**
- `<%= ... %>` → **Rubyの値をHTMLに埋め込む**

この構文は、JavaScriptの **テンプレートエンジン（e.g. JSX, Handlebars, EJS）** に似ています。

#### **JSX（Reactの場合）**
```jsx
// React（JSX）
function UserList({ users }) {
  return (
    <div>
      <h1>ユーザー一覧</h1>
      <ul>
        {users.map(user => <li key={user.id}>{user.name}</li>)}
      </ul>
    </div>
  );
}
```

JSXも **`{}` を使ってコードを埋め込む** のが特徴ですね。

---

## **4. まとめ**
| 比較項目 | Ruby | JavaScript |
|----------|------|------------|
| **制御構文** | `if ... end`, `while ... end` | `if {...}`, `while {...}` |
| **ループ** | `each`, `times` | `for`, `forEach` |
| **メソッド・関数** | `def ... end` | `function {...}`, `=>` |
| **クラス** | `class` + `def` | `class` + `constructor` |
| **非同期処理** | 基本は同期（Threadで非同期） | `async/await`, `Promise` |
| **テンプレート** | ERB (`<%= ... %>`) | JSX, EJS (`{ ... }`) |

### **理解のポイント**
- **「できること」はほぼ同じ（条件分岐、ループ、クラス、関数の定義）**
- **書き方（シンタックス）が違う**
- **Rubyは「シンプルで直感的な記述」、JavaScriptは「非同期やイベント駆動向き」**
- **ERBは JSX のように「テンプレートとしてデータを埋め込む」ことができる**
