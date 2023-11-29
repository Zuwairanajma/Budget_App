require 'rails_helper'

RSpec.describe EntityCategory, type: :model do
  let(:user) { User.create!(name: 'Juwairiyya', email: 'juwairiyya@test.com', password: 'password') }
  let(:entity_category) { EntityCategory.create!(author: user, name: 'Juwairiyya', amount: 500) }

  describe 'validations' do
    it 'should be valid with all valid attributes' do
      expect(entity_category).to be_valid
    end

    it 'should be valid if name is present' do
      entity_category.name = nil
      expect(entity_category).to be_valid
    end
  end

  describe 'associations' do
    it 'should belong to the correct user' do
      expect(entity_category.author).to eql user
    end

    it 'should include the correct categories' do
      category = GroupCategory.create!(author: user, name: 'Juwairiyya', icon: 'icon')
      CategoryItem.create!(group_category: category, entity_category:)
      expect(entity_category.group_categories).to include(category)
    end
  end
end
