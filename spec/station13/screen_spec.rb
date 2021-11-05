require 'rails_helper'

# HACK: Screenモデルを直接指定するとRspec自体の実行が失敗するため、指定していない
RSpec.describe 'Screen exits?' do
  describe 'station13 Does movies have a screen_id?' do

    it "Screenモデルが作成されていること" do
      expect(defined?(Screen)).to eq "constant"
    end
  end
end