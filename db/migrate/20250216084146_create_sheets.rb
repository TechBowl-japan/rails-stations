class CreateSheets < ActiveRecord::Migration[7.1]
  def change
    create_table :sheets do |t|
      # 座席の列
      t.integer :column, null: false, limit: 1
      # 座席の行
      t.string :row, null: false, limit: 1

      t.timestamps
    end
  end
end
