require 'rails_helper'

RSpec.describe 'GroupCategories', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(full_name: 'Juwairiyya', email: 'juwairiyya@gmail.com', password: 'password') }
  let(:category) { GroupCategory.create!(name: 'Journey', icon: GroupCategory::ICONS.keys.first, user:) }

  let(:valid_params) { { name: 'Fun', icon: GroupCategory::ICONS.keys.first } }
  let(:invalid_params) { { name: nil, icon: GroupCategory::ICONS.keys.first } }

  before do
    sign_in user
  end
  describe 'GET /index' do
    it 'returns http success' do
      get group_categories_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get new_group_category_path
      expect(response).to have_http_status(:success)
    end

    it 'should render categories/new template' do
      get new_group_category_path
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'should create a new Category' do
        expect do
          post group_categories_path, params: { group_category: valid_params }
        end.to change(GroupCategory, :count).by(1)
      end

      it 'should redirect to categories/index page' do
        post group_categories_path, params: { group_category: valid_params }
        expect(response).to redirect_to(group_categories_path)
      end
    end
  end
end
