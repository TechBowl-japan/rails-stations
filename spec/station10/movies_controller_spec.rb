require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  render_views
  describe 'Station10 GET /movies' do
    let!(:movie) { create(:movie) }
    before do
      @schedules = create_list(:schedule, 3, movie_id: movie.id)
      get :show, params: { id: movie.id }, session: {}
    end

    it 'movies(:id)に対応するレコードの情報が含まれていること' do
      expect(response.body).to include(movie.name).and include("#{movie.year}").and include(movie.description).and include(movie.image_url)
    end

    it 'movies(:id)に紐づくschedulesのレコード全件分のデータが出力されていること' do
      expect(response.body).to include(@schedules[0].start_time.to_s).and include(@schedules[2].start_time.to_s)
    end

    it 'movies(:id)「座席を予約する」ボタンが存在すること' do
      expect(response.body).to include("<button").and include("座席を予約する")
    end
  end
end
