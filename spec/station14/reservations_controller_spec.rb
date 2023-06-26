require 'rails_helper'

# 予約に関してこれまでの仕様が満たされていることのテスト
RSpec.describe ReservationsController, type: :controller do
  render_views
  describe 'Station14 GET /movies/:movie_id/schedules/:schedule_id/reservations/new' do
    let!(:failure_request) { get :new, params: { movie_id: 1, schedule_id: 1 }, session: {} }

    it 'date, sheet_idのどちらかまたは両方が渡されていないとき200を返していないこと' do
      expect(failure_request).not_to have_http_status(200)
    end
  end
end
