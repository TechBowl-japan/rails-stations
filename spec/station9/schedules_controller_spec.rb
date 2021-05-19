require 'rails_helper'
RSpec::Matchers.define_negated_matcher :not_include, :include

RSpec.describe SchedulesController, type: :controller do
  render_views
  describe 'Station9 PUT /schedules/:id' do
    let(:movie) { create(:movie) }
    let(:schedule) { create(:schedule, movie_id: movie.id) }
    let(:setting_time) { "2000-01-01 10:27:06 UTC" } 
    let(:schedule_attributes) { { start_time: setting_time } }
    before { post :update, params: { id: schedule.id, schedule: schedule_attributes }, session: {} }

    it '渡された時刻でschedule(:id)が更新されること' do
      updatedSchedule = Schedule.find(schedule.id)
      expect(updatedSchedule.start_time).to eq setting_time
    end
  end
end