class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :year
      t.integer :is_showing, limit:1
      t.string :image_url
      t.text :description

      t.timestamps
    end
  end
end
