require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  render_views
  describe 'Station1 GET /admin/movies' do
    before do
      create_list(:movie, 4)
      get 'index'
    end

    it '200を返すこと' do
      expect(response).to have_http_status(200)
    end

    it 'HTMLを返すこと' do
      expect(response.body).to include('<!DOCTYPE html>')
    end

    it 'HTMLの中にはmoviesテーブルのレコード数と同じ件数のデータがあること' do
      expect(controller.instance_variable_get("@movies")).to eq Movie.all
    end
  end
end