# class CreateGroupCategories < ActiveRecord::Migration[7.1]
#   def change
#     create_table :group_categories do |t|
#       t.string :name
#       t.string :icon
#       t.references :user, null: false, foreign_key: true

#       t.timestamps
#     end
#   end
# end
# db/migrate/xxxxxx_create_group_categories.rb

class CreateGroupCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :group_categories do |t|
      t.string :name
      t.string :icon

      t.timestamps
    end

    add_reference :group_categories, :user, null: false, foreign_key: true
  end
end
