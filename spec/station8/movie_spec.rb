require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:movie) { create(:movie) }
  let(:schedules) { create_pair(:schedule, movie_id: movie.id) }

  describe 'Relation' do
    it 'schedulesをhas_manyで引けること' do
      expect(movie.schedules).to match_array schedules
    end
  end
end