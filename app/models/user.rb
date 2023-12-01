class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :group_categories
  has_many :entity_categories

  validates :full_name, presence: true,
                        length: { maximum: 25, too_long: '%<count>s charecters is the maximum allowed' }
  validates :email, presence: true, uniqueness: true
end
