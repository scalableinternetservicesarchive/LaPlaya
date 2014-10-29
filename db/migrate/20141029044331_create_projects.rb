class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :instructions
      t.string :note
      t.string :content

      t.timestamps
    end
  end
end
