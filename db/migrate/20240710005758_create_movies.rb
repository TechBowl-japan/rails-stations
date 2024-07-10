class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string "name", limit: 160, null: false, index: true ,comment: "映画のタイトル。邦題・洋題は一旦考えなくてOK"
      t.string "year", limit: 45, comment: "公開年"
      t.text "description", comment: "映画の説明文"
      t.string "image_url", limit: 150, comment: "映画のポスター画像が格納されているURL"
      t.boolean "is_showing", null: false, comment: "上映中かどうか"

      t.timestamps
    end
  end
end
