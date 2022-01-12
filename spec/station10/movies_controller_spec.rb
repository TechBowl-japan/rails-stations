require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  render_views
  describe 'Station10 GET /movies/:id' do
    let!(:movie) { create(:movie) }
    let!(:schedule) { create_list(:schedule, 3, movie_id: movie.id) }
    before do
      get :show, params: { id: movie.id }, session: {}
    end

    context 'これまでの仕様' do
      it 'movies(:id)に対応するレコードの情報が含まれていること' do
        expect(response.body).to include(movie.name)
        expect(response.body).to include(movie.year.to_s)
        expect(response.body).to include(movie.description)
        expect(response.body).to include(movie.image_url)
      end

      it 'movies(:id)に紐づくschedulesのレコード全件分のデータが出力されていること' do
        expect(assigns(:schedules).count).to eq(3)
      end
    end

    context '追加の仕様' do
      it '「座席を予約する」ボタンが存在すること' do
        expect(response.body).to include("<button").and include("座席を予約する")
      end
    end
  end
end
