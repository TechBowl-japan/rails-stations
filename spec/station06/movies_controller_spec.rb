require 'rails_helper'
RSpec::Matchers.define_negated_matcher :not_include, :include

RSpec.describe MoviesController, type: :controller do
  render_views
  describe 'Station6 GET /movies' do
    before do
      @movies = create_list(:movie, 3)
      get 'index'
    end

    context "Station01の仕様" do
      it '200を返すこと' do
        expect(response).to have_http_status(200)
      end

      it 'HTMLを返すこと' do
        expect(response.body).to include('<!DOCTYPE html>')
      end

      it 'HTMLの中にはmoviesテーブルのレコード数と同じ件数のデータがあること' do
        expect(response.body).to include(@movies[0].name)
        expect(response.body).to include(@movies[1].name)
        expect(response.body).to include(@movies[2].name)
        expect(response.body).to include(@movies[0].image_url)
        expect(response.body).to include(@movies[1].image_url)
        expect(response.body).to include(@movies[2].image_url)
      end
    end

    context '映画作品リスト特有の仕様' do
      it 'method = getのformがある' do
        expect(response.body).to include('method')
        expect(response.body).to include('get').or include('GET')
      end

      it '検索キーワードを指定するとそれを含むものだけ表示' do
        selected_movie = create(:movie)
        get :index, params: { name: selected_movie.name }

        expect(response.body).to include(selected_movie.name)
        expect(response.body).to not_include(@movies[0].name)
        expect(response.body).to not_include(@movies[1].name)
        expect(response.body).to not_include(@movies[2].name)
      end

      it '公開中か公開前の切り替えができる' do
        create(:movie, is_showing: true)
        get :index, params: { is_showing: 1 }

        expect(response.body).to include("公開中")
        expect(response.body).to not_include("公開予定")
      end
    end
  end
end
