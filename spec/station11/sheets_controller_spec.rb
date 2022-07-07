require 'rails_helper'

RSpec.describe SheetsController, type: :controller do
  render_views
  describe 'Station11 GET /movies/:movie_id/reservation' do
    let!(:sheets) { create_list(:sheet, 15) }
    let(:movie) { create(:movie) }
    let(:schedule) { create(:schedule, movie_id: movie.id) }
    let(:success_request) { get :index, params: { movie_id: movie.id, schedule_id: schedule.id , date: "2021-12-21 14:53:56" }, session: {} }
    let(:no_schedule_request) { get :index, params: { movie_id: movie.id, date: "2021-12-21 14:53:56" }, session: {} }
    let(:no_date_request) { get :index, params: { movie_id: movie.id, schedule_id: schedule.id }, session: {} }

    context "クエリについて" do
      it 'dateが渡されていれば200を返すこと' do
        success_request
        expect(response).to have_http_status(200)
      end

      it 'パラメーターにschedule_idがないときに302を返していること' do
        no_schedule_request
        expect(response).to have_http_status(302)
      end

      it 'パラメーターにdateがないときに500を返していないこと' do
        no_date_request
        expect(response).not_to have_http_status(500)
      end
    end

    it 'HTMLの中にはtableタグがあること' do
      success_request
      expect(response.body).to include('</table>')
    end

    it '実装の中でsheetsテーブルにアクセスしていること' do
      success_request
      expect(assigns(:sheets)).to eq sheets
    end
  end
end
