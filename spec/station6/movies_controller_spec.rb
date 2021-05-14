require 'rails_helper'
RSpec::Matchers.define_negated_matcher :not_include, :include

RSpec.describe MoviesController, type: :controller do
  render_views
  describe 'Station6 GET /admin/movies' do
    let!(:movies) { create_list(:movie, 3) }
    before do
      get 'index'
    end

    it '200を返すこと' do
      expect(response).to have_http_status(200)
    end

    it 'HTMLを返すこと' do
      expect(response.body).to include('<!DOCTYPE html>')
    end

    it 'HTMLの中にはmoviesテーブルのレコード数と同じ件数のデータがあること' do
      expect(response.body).to include(movies[0].name).and include(movies[1].name).and include(movies[2].name).and include(movies[0].image_url).and include(movies[1].image_url).and include(movies[2].image_url)
    end
  end
end
