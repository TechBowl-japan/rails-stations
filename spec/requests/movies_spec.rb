require 'rails_helper'

RSpec.describe "Movies", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/movies/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/movies/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/movies/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/movies/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
