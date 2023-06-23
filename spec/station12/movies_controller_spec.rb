require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  render_views
  describe 'Station12 GET /movies/:id' do
    let!(:movie) { create(:movie) }
    let!(:schedule) { create_list(:schedule, 3, movie_id: movie.id) }
    before do
      get :show, params: { id: movie.id }, session: {}
    end

    context 'ページの仕様' do
      it '1週間先まで選択可能な日付のプルダウンメニューが存在すること' do
        for num in 0..6 do
          expect(response.body).to include('<select').and include('value="' + Date.today.next_day(num).to_s + '"')
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

    context 'エンドポイントの仕様' do
      describe 'Station12 GET /movies/:id/reservation' do
        let!(:sheets) { create_list(:sheet, 15) }
        let!(:movie) { create(:movie) }
        let!(:schedule) { create(:schedule, movie_id: movie.id) }
        let(:success_request) do
          get :reservation, params: { id: movie.id, movie_id: movie.id, schedule_id: schedule.id, date: '2021-12-21 14:53:56' },
                            session: {}
        end
        let(:no_date_request) do
          get :reservation, params: { id: movie.id, movie_id: movie.id, schedule_id: schedule.id }, session: {}
        end
        let(:no_schedule_request) do
          get :reservation, params: { id: movie.id, movie_id: movie.id, date: '2021-12-21 14:53:56' }, session: {}
        end
        let(:no_date_and_sheet_request) { get :reservation, params: { id: movie.id, movie_id: movie.id }, session: {} }

        context 'クエリについて' do
          it 'schedule_idとdateが渡されていれば200を返すこと' do
            success_request
            expect(response).to have_http_status(200)
          end

          it 'パラメーターにschedule_idがないときに302を返していること' do
            no_schedule_request
            expect(response).to have_http_status(302)
          end

          it 'パラメーターにdateがないときに302を返していること' do
            no_date_request
            expect(response).to have_http_status(302)
          end

          it 'パラメーターにdateとschedule_idがないときに302を返していること' do
            no_date_and_sheet_request
            expect(response).to have_http_status(302)
          end
        end

        it '実装の中でsheetsテーブルにアクセスしていること' do
          success_request
          expect(assigns(:sheets)).to eq sheets
        end
      end
    end
  end
end
