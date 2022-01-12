require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'station10 attribute: email' do
    let(:schedule) { create(:schedule, movie_id: create(:movie).id) }
    let(:reservation) { build(:reservation, { sheet_id: create(:sheet).id, schedule_id: schedule.id }) }

    example "メールアドレスの形式のバリデーションができていること" do
      reservation.email = 'techbowl@example.com'
      expect(reservation).to be_valid

      reservation.email = 'a@a.a'
      expect(reservation).to be_valid

      reservation.email = 'a.a@a.a'
      expect(reservation).to be_valid

      reservation.email = 'a@a'
      expect(reservation).not_to be_valid

      reservation.email = 'bbb'
      expect(reservation).not_to be_valid

      reservation.email = 'ccc@'
      expect(reservation).not_to be_valid

      reservation.email = '@ddd'
      expect(reservation).not_to be_valid
    end
  end
end