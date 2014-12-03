class AddIdColumnToHmtTables < ActiveRecord::Migration
  def change
    add_column :taggings, :id, :primary_key
    add_column :project_likes, :id, :primary_key
  end
end
