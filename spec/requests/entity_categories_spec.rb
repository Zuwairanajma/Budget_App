require 'rails_helper'

RSpec.describe 'EntityCategories', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user) { User.create!(name: 'Juwairiyya', email: 'juwairiyya@test.com', password: 'password') }
  let(:category) { GroupCategory.create!(name: 'Journey', icon: 'icon', author: user) }

  let(:valid_params) { { name: 'Kota', amount: 5 } }
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

    it 'should assign @category and @item' do
      get new_group_category_entity_category_path(category)
      expect(assigns(:category)).to eq(category)
      expect(assigns(:entity_category)).to be_a_new(EntityCategory)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'should create a new Item' do
        expect do
          post group_category_entity_categories_path(category), params: { entity_category: valid_params }
        end.to change(EntityCategory, :count).by(1)
      end

      it 'should Item with the Category' do
        post group_category_entity_categories_path(category), params: { entity_category: valid_params }
        expect(category.entity_categories).to include(assigns(:entity_category))
      end

      it 'should redirect to category/show page' do
        post group_category_entity_categories_path(category), params: { entity_category: valid_params }
        expect(response).to redirect_to(group_category_path(category))
      end
    end
  end
end
