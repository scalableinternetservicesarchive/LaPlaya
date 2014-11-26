class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings, id: false do |t|
      t.references :project, index: true
      t.references :tag, index: true
    end
    add_column :tags, :taggings_count, :integer, default: 0, null: false
  end
end
