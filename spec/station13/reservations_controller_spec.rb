require 'rails_helper'

# 予約に関してこれまでの仕様が満たされていることのテスト
RSpec.describe ReservationsController, type: :controller do
  render_views
  describe 'Station13 GET /movies/:movie_id/schedules/:schedule_id/reservations/new' do
    let!(:movie) { create(:movie) }
    let!(:sheets) { create_list(:sheet, 5) }
    let!(:schedule) { create(:schedule, movie_id: movie.id) }
    let(:success_request) { get :new, params: { date: "2019-04-16", sheet_id: sheets.first.id , movie_id: movie.id, schedule_id: schedule.id }, session: {} }
    let(:failure_request) { get :new, params: { movie_id: movie.id, schedule_id: schedule.id }, session: {} }

    it 'date, sheet_idの両方があるときだけ200を返すこと' do
      success_request
      expect(response).to have_http_status(200)
    end

    it 'date, sheet_idのどちらかまたは両方が渡されていないとき200を返していないこと' do
      failure_request
      expect(response).not_to have_http_status(200)
    end
  end
end
