require 'rails_helper'

RSpec.describe Screen, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:sheets) }
    it { should have_many(:schedules) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:screen)).to be_valid
    end
  end
end
