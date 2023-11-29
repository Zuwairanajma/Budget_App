class CreateCategoryItems < ActiveRecord::Migration[7.1]
  def change
    create_table :category_items do |t|
      t.references :group_category, null: false, foreign_key: true
      t.references :entity_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
