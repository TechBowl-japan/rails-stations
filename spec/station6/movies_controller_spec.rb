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

    it 'method = getのformがある' do
      expect(response.body).to include('method="get"')
    end

    context '検索時' do
      # factoriesのis_showingのデフォルトでは1
      let(:show_estimated) { create(:movie, is_showing: 0 ) }
      let(:showed_movie) { create(:movie, is_showing: 1 ) }
  
      it '検索キーワードを指定するとそれを含むものだけ表示' do
        get :index, params: { name: show_estimated.name, is_showing: "" }
        expect(response.body).to include(show_estimated.name)
        expect(response.body).to not_include(showed_movie.name)
      end

      it '公開中か公開前の切り替えができる' do
        get :index, params: { name: "", is_showing: 1 }
        expect(response.body).to include("公開予定")
      end
    end
  end
end
