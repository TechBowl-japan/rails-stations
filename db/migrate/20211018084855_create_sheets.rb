class CreateSheets < ActiveRecord::Migration[6.1]
  def change
    create_table :sheets, auto_increment: true, :null => false do |t|
      t.integer :column, :limit => 5, :null => false
      t.string :row, :limit => 1, :null => false

      t.timestamps
    end
  end
end
