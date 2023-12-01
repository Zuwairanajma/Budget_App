require 'rails_helper'

RSpec.describe EntityCategory, type: :model do
  let(:user) { User.create!(full_name: 'Juwairiyya', email: 'juwairiyya@test.com', password: 'password') }
  let(:category) { GroupCategory.create!(user:, name: 'Juwairiyya', icon: GroupCategory::ICONS.keys.first) }
  let(:entity_category) do
    EntityCategory.create!(user:, name: 'Juwairiyya', amount: 500, group_category: category)
  end

  describe 'validations' do
    it 'should be valid with all valid attributes' do
      expect(entity_category).to be_valid
    end

    it 'should be valid if name is present' do
      entity_category.name = 'Juwairiyya'
      expect(entity_category).to be_valid
    end
  end

  describe 'associations' do
    it 'should belong to the correct user' do
      expect(entity_category.user).to eql user
    end

    it 'should include the correct categories' do
      expect(entity_category.group_category).to eq(category)
    end
  end
end
