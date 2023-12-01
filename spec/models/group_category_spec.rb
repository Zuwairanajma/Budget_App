require 'rails_helper'

RSpec.describe GroupCategory, type: :model do
  let(:user) { User.create!(full_name: 'Juwairiyya', email: 'juwairiyya@test.com', password: 'password') }
  let(:category) { GroupCategory.create!(user:, name: 'Juwairiyya', icon: GroupCategory::ICONS.keys.first) }
  let!(:entity_category) do
    EntityCategory.create!(user:, name: 'Juwairiyya', amount: 500, group_category: category)
  end

  describe 'validations' do
    it 'should be valid with all valid attributes' do
      expect(category).to be_valid
    end

    it 'should  be valid if name is present' do
      category.name = 'Juwairiyya'
      expect(category).to be_valid
    end
  end

  describe 'associations' do
    it 'should belong to the correct user' do
      expect(category.user).to eql user
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
