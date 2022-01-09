class ChangeTypeIsShowingOfMovies < ActiveRecord::Migration[6.1]
  def change
    change_column :movies, :is_showing, :boolean, default: false, null: false
  end
end
