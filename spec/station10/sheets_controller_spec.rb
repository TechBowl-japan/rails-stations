require 'rails_helper'

RSpec.describe SheetsController, type: :controller do
  render_views
  describe 'Station10 GET ' do
    let!(:sheets) { create_list(:sheet, 15) } 
    let!(:movie) { create(:movie) } 
    let!(:schedule) { create(:schedule, movie_id: movie.id) } 
    let(:success_request) { get :index, params: { movie_id: movie.id, schedule_id: schedule.id , date: "2019-04-16" }, session: {} } 
    let(:failure_request) { get :index, params: { movie_id: movie.id, schedule_id: schedule.id }, session: {} } 

    it 'dateが渡されていれば200を返すこと' do
      success_request
      expect(response).to have_http_status(200)
    end

    it 'HTMLの中にはtableタグがあること' do
      success_request
      expect(response.body).to include('</table>')
    end

    it '実装の中でsheetsテーブルにアクセスしていること' do
      success_request
      expect(response.body).to include("#{sheets.first.column}").and include("#{sheets.last.column}")
    end

    it 'クエリパラメータがないときに500を返していない' do
      failure_request
      expect(response).not_to have_http_status(500)
    end
  end
end
