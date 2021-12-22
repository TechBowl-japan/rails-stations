require 'rails_helper'

RSpec.describe Movie, type: :model do
  before do
    @movie = create(:movie)
    @other = create(:movie)
  end

  it "タイトルは一意" do
    @other.name =  @movie.name
    expect(@other.valid?).to eq(false)
  end
end
