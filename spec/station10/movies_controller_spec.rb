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
        expect(response.body).to include("<input").and include("座席を予約する")
      end
    end
  end

  describe 'Station10 GET /movies/:id/reservation' do
    let!(:sheets) { create_list(:sheet, 15) }
    let!(:movie) { create(:movie) }
    let!(:schedule) { create(:schedule, movie_id: movie.id) }
    let(:success_request) { get :reservation, params: { id: movie.id, movie_id: movie.id, schedule_id: schedule.id, date: "2021-12-21 14:53:56" }, session: {} }
    let(:no_date_request) { get :reservation, params: { id: movie.id, movie_id: movie.id, schedule_id: schedule.id }, session: {} }
    let(:no_schedule_request) { get :reservation, params: { id: movie.id, movie_id: movie.id, date: "2021-12-21 14:53:56" }, session: {} }
    let(:no_date_and_sheet_request) { get :reservation, params: { id: movie.id, movie_id: movie.id }, session: {} }

    context "クエリについて" do
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
