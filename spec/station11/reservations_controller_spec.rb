require 'rails_helper'

RSpec.describe ReservationsController, type: :controller do
  render_views
  describe 'Station11 POST /reservation/' do
    let(:movie) { create(:movie) }
    let(:sheets) { create_list(:sheet, 5) }
    let(:schedule) { create(:schedule, movie_id: movie.id) }

    it '予約できない席を指定して予約した際にflash[:alert]でエラー表示をしている' do
      target_sheet_id = sheets.first.id
      create(:reservation, { sheet_id: target_sheet_id, schedule_id: schedule.id, date: "2019-04-16" })

      post :create, params: { reservation: { name: "TEST_NAME", email: "test@test.com", date: "2019-04-16", sheet_id: target_sheet_id , schedule_id: schedule.id, movie_id: movie.id }}, session: {}
      expect(flash[:alert]).to be_present
    end
  end
end
