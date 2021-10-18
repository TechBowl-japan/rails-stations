require 'rails_helper'

RSpec.describe "Sheets", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/sheets/index"
      expect(response).to have_http_status(:success)
    end
  end

end
