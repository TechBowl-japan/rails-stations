require 'rails_helper'

RSpec.describe Admin::SchedulesController, type: :controller do
  render_views
  describe 'Station9 GET /admin/schedules/:id' do
    let!(:movie) { create(:movie) }
    let!(:schedule) { create(:schedule, movie_id: movie.id) }
    before { get :edit, params: { id: schedule.id, movie_id: movie.id } }

    it '時刻のフォームに時刻以外のものを入力できないこと' do
      # TODO: capybaraでテスト実装
    end

    it 'フォーム送信でPUT /schedule/:id に送信されること' do
      expect(response.body).to include('action="/admin/schedules/')
    end
  end

  describe 'Station9 PUT /schedules/:id' do
    let!(:movie) { create(:movie) }
    let!(:schedule) { create(:schedule, movie_id: movie.id) }
    let!(:setting_time) { "2000-01-01 10:27:06 UTC" } 
    let!(:schedule_attributes) { { start_time: setting_time } }
    before { post :update, params: { id: schedule.id, schedule: schedule_attributes }, session: {} }

    it '渡された時刻でschedule(:id)が更新されること' do
      updatedSchedule = Schedule.find(schedule.id)
      expect(updatedSchedule.start_time).to eq setting_time
    end
  end

  describe 'Station9 DELETE /schedule/:id' do
    let!(:movie) { create(:movie) }
    let!(:schedule) { create(:schedule, movie_id: movie.id) }

    it '渡された時刻でschedule(:id)が更新されること' do
      expect do
        delete :destroy, params: { id: schedule.id }, session: {}
      end.to change(Schedule, :count).by(-1)
    end
  end
end