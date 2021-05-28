require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'Station15 GET /users/new' do
    before { get '/users/new' }

    it '200が返ること' do
      expect(response).to have_http_status(200)
    end
  end
end
