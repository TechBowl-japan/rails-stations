require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  render_views
  describe 'Station11 GET /movies/:id' do
    let!(:movie) { create(:movie) }
    let!(:schedule) { create_list(:schedule, 3, movie_id: movie.id) }
    before do
      get :show, params: { id: movie.id }, session: {}
    end

    context 'ページの仕様' do
      it '1週間先まで選択可能な日付のプルダウンメニューが存在すること' do
        for num in 0..6 do
          expect(response.body).to include('<select').and include('value="'+Date.today.next_day(num).to_s()+'"')
        end
      end

      it '上映スケジュールリストから1つの時刻を選択するプルダウンメニューが存在すること' do
        for menu in schedule do
          expect(response.body).to include('<option').and include(menu.id.to_s)
        end
      end

      it '「座席を予約する」ボタンが存在すること' do
        expect(response.body).to include('<button').and include('座席を予約する')
      end

      it '「座席を予約する」ボタンを押すと`/movies/:movie_id/reservation`に遷移すること' do
        expect(response.body).to include('<form').and include('action="/movies/' + movie.id.to_s + '/reservation')
      end
    end
  end
end
