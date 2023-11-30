require 'rails_helper'

RSpec.describe CategoryItem, type: :model do
  let(:user) { User.create!(name: 'Naledi', email: 'juwairiyya@test.com', password: 'password') }
  let(:entity_category) { EntityCategory.create!(author: user, name: 'Juwairiyya', amount: 500) }
  let(:group_category) { GroupCategory.create!(author: user, name: 'Juwairiyya', icon: 'icon') }
  let(:category_item) { CategoryItem.create!(group_category:, entity_category:) }

  describe 'associations' do
    it 'should belong to a category' do
      expect(category_item.group_category).to eq(group_category)
    end

    it 'should belong to an item' do
      expect(category_item.entity_category).to eq(entity_category)
    end
  end
end
