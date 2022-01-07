class AddYearToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :year, :integer
    add_column :movies, :description, :string
    add_column :movies, :is_showing, :integer
  end
end
