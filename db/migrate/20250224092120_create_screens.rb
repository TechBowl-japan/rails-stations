class CreateScreens < ActiveRecord::Migration[7.1]
  def change
    create_table :screens do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index :screens, :name, unique: true
  end
end
