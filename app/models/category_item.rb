class CategoryItem < ApplicationRecord
  belongs_to :group_category
  belongs_to :entity_category
end
