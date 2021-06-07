require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'station11 attribute: email' do
    let(:movie) { create(:movie) } 
    let(:sheet) { create(:sheet) } 
    let(:schedule) { create(:schedule, movie_id: movie.id) } 
    let(:reservation) { build(:reservation, { sheet_id: sheet.id, schedule_id: schedule.id }) }

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