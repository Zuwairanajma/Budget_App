class EntityCategory < ApplicationRecord
  belongs_to :user
  belongs_to :group_category

  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :group_category, presence: true
end
