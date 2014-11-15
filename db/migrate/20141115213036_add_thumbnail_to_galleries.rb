class AddThumbnailToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :thumbnail, :string
  end
end
