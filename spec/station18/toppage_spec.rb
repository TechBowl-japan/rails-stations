require 'rails_helper'

RSpec.describe do
  render_views
  describe 'Station18　GET /' do
    before { get '/' }

    it '200が返ること' do
      expect(response).to have_http_status(200)
    end

    it 'トップページがあること' do
      expect(response.body).to include("ランキング").or include("ranking").or include("Ranking")
    end
  end
end
