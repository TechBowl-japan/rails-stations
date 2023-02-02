require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  render_views
  describe 'Station10 GET /movies/:movie_id/schedules/:schedule_id/reservations/new' do
    let(:movie) { create(:movie) }
    let(:sheets) { create_list(:sheet, 5) }
    let(:date) { "2023-01-31" }
    let(:schedule) { create(:schedule, movie_id: movie.id) }
    let(:success_request) { get :new, params: { movie_id: movie.id, schedule_id: schedule.id, date: date, sheet_id: sheets.first.id }, session: {} }
    let(:no_date_and_sheet_request) { get :new, params: { movie_id: movie.id, schedule_id: schedule.id }, session: {} }
    let(:no_date_request) { get :new, params: { movie_id: movie.id, schedule_id: schedule.id, sheet_id: sheets.first.id }, session: {} }
    let(:no_sheet_request) { get :new, params: { movie_id: movie.id, schedule_id: schedule.id, date: date }, session: {} }

    context "クエリについて" do
      it 'date, sheet_idの両方があるときだけ200を返すこと' do
        success_request
        expect(response).to have_http_status(200)
      end

      it 'date, sheet_idの両方が渡されていないとき200を返していないこと' do
        no_date_and_sheet_request
        expect(response).not_to have_http_status(200)
      end

      it 'dateが渡されていないとき200を返していないこと' do
        no_date_request
        expect(response).not_to have_http_status(200)
      end

      it 'sheet_idが渡されていないとき200を返していないこと' do
        no_sheet_request
        expect(response).not_to have_http_status(200)
      end
    end

    it 'form送信時にmovie_id, schedule_id, sheet_id, name, emailのすべてを送信するようになっていること' do
      success_request
      expect(response.body).to include("name")
      expect(response.body).to include("email")
      expect(response.body).to include("schedule_id")
      expect(response.body).to include("sheet_id")
    end
  end

  describe 'Station10 POST /reservation/' do
    let(:movie) { create(:movie) }
    let(:sheets) { create_list(:sheet, 5) }
    let(:date) { "2023-01-31" }
    let(:schedule) { create(:schedule, movie_id: movie.id) }
    let(:success_request) { post :create, params: { reservation: { name: "TEST_NAME", email: "test@test.com", date: date, sheet_id: sheets.first.id , schedule_id: schedule.id, movie_id: movie.id }}, session: {} }

    it 'schedule_id, sheet_id, name, email, dateのすべてがあるときに302を返す' do
      success_request
      expect(response).to have_http_status(302)
    end

    it 'DBのunique制約にかかったときにリダイレクトテスト' do
      # 同じ日付の同じ映画の座席を予約してみる
      create(:reservation, { sheet_id: sheets.first.id, schedule_id: schedule.id, date: date })
      success_request
      # NOTE: movie_reservation_pathとして指定したいが、実装の揺れに対応するために文字列で指定している
      expect(response).to redirect_to("http://test.host/movies/#{movie.id}/reservation?schedule_id=#{schedule.id}&date=#{date}").or redirect_to("http://test.host/movies/#{movie.id}/reservation?date=#{date}&schedule_id=#{schedule.id}")
    end
  end
end
