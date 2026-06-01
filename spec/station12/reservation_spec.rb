require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'Station12 Are date&schedule_id&seat_id unique?' do
    let(:movie) { create(:movie) }
    let(:seat) { create(:seat) }
    let(:schedule) { create(:schedule, movie_id: movie.id) }
    let(:reservation) { create(:reservation, { seat_id: seat.id, schedule_id: schedule.id }) }
    let(:duplicated_reservation) { build(:reservation, { seat_id: seat.id, schedule_id: schedule.id, date: reservation.date }) }

    it "変更することで他の予約と全く同じような予約になること" do
      expect(duplicated_reservation).not_to be_valid
    end
  end
end
