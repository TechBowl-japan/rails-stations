class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :year
      t.text :description
      t.string :image_url
      t.boolean :is_showing

      t.timestamps
    end
  end
end
