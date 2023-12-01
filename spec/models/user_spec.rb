require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(full_name: 'Juwairiyya', email: 'juwairiyya@test.com', password: 'password') }

  describe 'validations' do
    it 'should be valid with all valid attributes' do
      expect(user).to be_valid
    end

    it 'should be valid if name is present' do
      user.full_name = 'Juwairiyya'
      expect(user).to be_valid
    end
  end
end
