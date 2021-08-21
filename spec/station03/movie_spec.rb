require 'rails_helper'

RSpec.describe Movie, type: :model do

  before do
    @movie = create(:movie)
    @other = create(:movie)
  end

  example "" do
    @other.name =  @movie.name
    expect(@other.valid?).to eq(false)
  end
end