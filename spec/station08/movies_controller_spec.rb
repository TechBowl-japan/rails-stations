require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  render_views
  describe 'Station6 GET /movies/:id' do
    let!(:movie) { create(:movie) }
    let!(:schedules) { create_list(:schedule, 5, movie: movie) }
    before do
      get :show, params: { id: movie.id }, session: {}
    end

    it 'movies(:id)に対応するレコードの情報が含まれていること' do
      expect(response.body).to include(movie.name)
      expect(response.body).to include(movie.year)
      expect(response.body).to include(movie.description)
      expect(response.body).to include(movie.image_url)
    end

    it 'movies(:id)に紐づくschedulesのレコード全件分のデータが出力されていること' do
      expect(assigns(:schedules)).to eq schedules
    end
  end
end
