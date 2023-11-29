class AddTrueIdToGroupCategories < ActiveRecord::Migration[7.1]
  def change
    add_column :group_categories, :true_id, :integer
  end
end
