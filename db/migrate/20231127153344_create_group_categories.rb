class CreateGroupCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :group_categories do |t|
      t.string :name
      t.string :icon
      t.references :author, true, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
