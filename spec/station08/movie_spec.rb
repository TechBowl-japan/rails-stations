require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'Station08 Relation test' do
    it 'schedulesをhas_manyで引けること' do
      movie     = create(:movie)
      schedules = create_pair(:schedule, movie_id: movie.id)

      expect(movie.schedules).to match_array schedules
    end
  end
end
