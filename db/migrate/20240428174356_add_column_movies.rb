class AddColumnMovies < ActiveRecord::Migration[6.1]
  def change
    add_reference :movies, :screen, foreign_key: true
  end
end
