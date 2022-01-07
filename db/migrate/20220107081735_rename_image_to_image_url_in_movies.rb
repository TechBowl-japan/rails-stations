class RenameImageToImageUrlInMovies < ActiveRecord::Migration[6.1]
  def up
    rename_column :movies, :image, :image_url
  end

  def down
    rename_column :movies, :image_url, :image
  end
end
