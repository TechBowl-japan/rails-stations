class RenameTitleToNameInMovies < ActiveRecord::Migration[6.1]
  def up
    rename_column :movies, :title, :name
  end

  def down
    rename_column :movies, :name, :title
  end
end
