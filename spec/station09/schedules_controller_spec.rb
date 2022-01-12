require 'rails_helper'

RSpec.describe Admin::SchedulesController, type: :controller do
  render_views
  describe 'Station9 GET /admin/movies/:movie_id/schedules/:schedule_id' do
    before do
      @movie = create(:movie)
      @schedule = create(:schedule, movie_id: @movie.id)

      get :edit, params: { id: @schedule.id, movie_id: @movie.id }
    end

    it '時刻のフォームに時刻以外のものを入力できないこと' do
      # TODO: capybaraでテスト実装
    end

    it 'フォーム送信でPUT /admin/movies/:movie_id/schedules/:schedule_id に送信されること' do
      expect(response.body).to include(`action="/admin/movies/#{@movie.id}/schedules/#{@schedule.id}`)
    end
  end

  describe 'Station9 PUT /admin/movies/:movie_id/schedules/:schedule_id' do

    it '渡された時刻でschedule(:id)が更新されること' do
      setting_time = "2000-01-01 10:27:06 UTC"
      movie = create(:movie)
      schedule = create(:schedule, movie_id: movie.id)
      patch :update, params: { id: schedule.id, movie_id: movie.id, schedule: { start_time: setting_time } }

      expect(schedule.reload.start_time).to eq setting_time
    end
  end

  describe 'Station9 DELETE /admin/movies/:movie_id/schedules/:schedule_id' do

    it '渡された時刻でschedule(:id)が更新されること' do
      movie = create(:movie)
      schedule = create(:schedule, movie_id: movie.id )

      expect do
        delete :destroy, params: { id: schedule.id, movie_id: movie.id, }
      end.to change(Schedule, :count).by(-1)
    end
  end
end