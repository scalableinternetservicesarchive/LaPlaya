class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :about
      t.text :instructions
      t.string :content

      t.timestamps
    end
  end
end
