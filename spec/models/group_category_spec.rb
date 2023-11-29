require 'rails_helper'

RSpec.describe GroupCategory, type: :model do
  let(:user) { User.create!(name: 'Juwairiyya', email: 'juwairiyya@test.com', password: 'password') }
  let(:category) { GroupCategory.create!(author: user, name: 'Juwairiyya', icon: 'icon') }
  let!(:entity_category) { EntityCategory.create!(author: user, name: 'Juwairiyya', amount: 500) }
  let!(:category_item) { CategoryItem.create!(group_category: category, entity_category:) }

  describe 'validations' do
    it 'should be valid with all valid attributes' do
      expect(category).to be_valid
    end

    it 'should  be valid if name is present' do
      category.name = nil
      expect(category).to be_valid
    end
  end

  describe 'associations' do
    it 'should belong to the correct user' do
      expect(category.author).to eql user
    end

    it 'should include correct item' do
      expect(category.entity_categories).to include(entity_category)
    end
  end

  describe 'total_amount' do
    it 'should calculate the total amount of items' do
      expect(category.total_amount).to eq(entity_category.amount)
    end
  end
end
