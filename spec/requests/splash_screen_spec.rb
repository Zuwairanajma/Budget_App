require 'rails_helper'

RSpec.describe 'SpashScreens', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      # get "/spash_screen/index"
      get splash_screen_index_path
      expect(response).to have_http_status(:success)
    end
  end
end
