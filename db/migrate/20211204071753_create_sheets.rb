class CreateSheets < ActiveRecord::Migration[6.1]
  def change
    create_table :sheets do |t|
      t.integer :column, limit:1
      t.string :row

      t.timestamps
    end
  end
end
