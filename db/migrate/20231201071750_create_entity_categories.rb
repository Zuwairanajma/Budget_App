class CreateEntityCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :entity_categories do |t|
      t.string :name
      t.decimal :amount
      t.references :user, null: false, foreign_key: true
      t.references :group_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
