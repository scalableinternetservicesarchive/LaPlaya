class CreateProjectLikes < ActiveRecord::Migration
  def change
    create_table :project_likes, id: false do |t|
      t.references :project
      t.references :user
    end
    add_index :project_likes, [:project_id, :user_id], unique: true
    add_index :project_likes, :user_id

    add_column :projects, :project_likes_count, :integer, default: 0, null: false
  end
end
