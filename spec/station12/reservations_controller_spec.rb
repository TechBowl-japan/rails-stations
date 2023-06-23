require 'rails_helper'

# 予約に関してこれまでの仕様が満たされていることのテスト
RSpec.describe ReservationsController, type: :controller do
  render_views
  describe 'Station11 GET /movies/:movie_id/schedules/:schedule_id/reservations/new' do
    let!(:movie) { create(:movie) }
    let!(:sheets) { create_list(:sheet, 5) }
    let!(:date) { '2023-01-31' }
    let!(:schedule) { create(:schedule, movie_id: movie.id) }
    let!(:success_request) do
      get :new, params: { movie_id: movie.id, schedule_id: schedule.id, date: date, sheet_id: sheets.first.id },
                session: {}
    end
    let!(:no_date_and_sheet_request) { get :new, params: { movie_id: movie.id, schedule_id: schedule.id }, session: {} }
    let!(:no_date_request) do
      get :new, params: { movie_id: movie.id, schedule_id: schedule.id, sheet_id: sheets.first.id }, session: {}
    end
    let!(:no_sheet_request) do
      get :new, params: { movie_id: movie.id, schedule_id: schedule.id, date: date }, session: {}
    end

    context 'クエリについて' do
      it 'date, sheet_idの両方があるときだけ200を返すこと' do
        expect(success_request).to have_http_status(200)
      end

      it 'date, sheet_idの両方が渡されていないとき200を返していないこと' do
        expect(no_date_and_sheet_request).not_to have_http_status(200)
      end

      it 'dateが渡されていないとき200を返していないこと' do
        expect(no_date_request).not_to have_http_status(200)
      end

      it 'sheet_idが渡されていないとき200を返していないこと' do
        expect(no_sheet_request).not_to have_http_status(200)
      end
    end

    it 'form送信時にmovie_id, schedule_id, sheet_id, name, emailのすべてを送信するようになっていること' do
      expect(success_request.body).to include('name')
      expect(success_request.body).to include('email')
      expect(success_request.body).to include('schedule_id')
      expect(success_request.body).to include('sheet_id')
    end
  end

  describe 'Station11 POST /reservation/' do
    let!(:movie) { create(:movie) }
    let!(:sheets) { create_list(:sheet, 5) }
    let!(:date) { '2023-01-31' }
    let!(:schedule) { create(:schedule, movie_id: movie.id) }
    let!(:duplicated_date_reservation_test) do
      create(:reservation, { sheet_id: sheets.first.id, schedule_id: schedule.id, date: date })
    end

    let(:success_request) do
      post :create,
           params: { reservation: { name: 'TEST_NAME', email: 'test@test.com', date: date, sheet_id: sheets.first.id, schedule_id: schedule.id, movie_id: movie.id } }, session: {}
    end

    it 'schedule_id, sheet_id, name, email, dateのすべてがあるときに302を返す' do
      expect(success_request).to have_http_status(302)
    end

    it 'DBのunique制約にかかったときにリダイレクトテストされる' do
      duplicated_date_reservation_test
      success_request
      # NOTE: movie_reservation_pathとして指定したいが、実装の揺れに対応するために文字列で指定している
      expect(response).to redirect_to("http://test.host/movies/#{movie.id}/reservation?schedule_id=#{schedule.id}&date=#{date}").or redirect_to("http://test.host/movies/#{movie.id}/reservation?date=#{date}&schedule_id=#{schedule.id}")
    end
  end
end
