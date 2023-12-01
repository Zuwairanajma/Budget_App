require 'rails_helper'

RSpec.describe 'SplashScreens', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get unauthenticated_root_path
      expect(response).to have_http_status(:success)
    end
  end
end
