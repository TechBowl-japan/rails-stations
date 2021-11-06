require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  render_views
  describe 'Station6 GET /movies' do
    let!(:movie) { create(:movie) }
    before do
      @schedules = create_list(:schedule, 3, movie_id: movie.id)
      get :show, params: { id: movie.id }, session: {}
    end 

    it 'movies(:id)に対応するレコードの情報が含まれていること' do
      expect(response.body).to include(movie.name).and include("#{movie.year}").and include(movie.description).and include(movie.image_url)
    end

    it 'movies(:id)に紐づくschedulesのレコード全件分のデータが出力されていること' do
      # binding.irb
      expect(response.body).to include(@schedules[0].start_time.to_s).and include(@schedules[2].start_time.to_s)
    end
  end
end
