class CreateGalleriesProjectsJoinTable < ActiveRecord::Migration
  def change
    create_table :galleries_projects, id: false do |t|
      t.integer :gallery_id
      t.integer :project_id
    end
  end
end
