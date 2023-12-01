require 'rails_helper'

RSpec.describe 'EntityCategories', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(full_name: 'Juwairiyya Sadiq', email: 'juwairiyya@test.com', password: 'password') }
  let(:category) { GroupCategory.create!(name: 'Journey', icon: GroupCategory::ICONS.keys.first, user:) }

  let(:valid_params) { { name: 'Kota', amount: 5, group_category_id: category.id } }
  let(:invalid_params) { { name: nil, amount: 5 } }

  before do
    sign_in user
  end

  describe 'GET /new' do
    it 'should return a 200 OK status' do
      get new_group_category_entity_category_path(category)
      expect(response).to have_http_status(:ok)
    end

    it 'should render items/new template' do
      get new_group_category_entity_category_path(category)
      expect(response).to render_template(:new)
    end

    it 'should assign @category and @entity_category' do
      get new_group_category_entity_category_path(category)
      expect(assigns(:group_category)).to eq(category)
      expect(assigns(:entity_category).group_category).to eq(category)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'should create a new EntityCategory' do
        expect do
          post group_category_entity_categories_path(category), params: { entity_category: valid_params }
        end.to change(EntityCategory, :count).by(1)
      end

      it 'should associate the EntityCategory with the Category' do
        post group_category_entity_categories_path(category), params: { entity_category: valid_params }
        expect(category.entity_categories).to include(assigns(:entity_category))
      end

      it 'should redirect to category/show page' do
        post group_category_entity_categories_path(category), params: { entity_category: valid_params }
        expect(response).to redirect_to(group_category_entity_categories_path(category))
      end
    end
  end
end
