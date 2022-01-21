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
        keyword = 'selected_movie'
        selected_movie_by_name = create(:movie, name: keyword)
        selected_movie_by_description = create(:movie, description: keyword)
        get :index, params: { keyword: keyword }

        expect(response.body).to include(selected_movie_by_name.name)
        expect(response.body).to include(selected_movie_by_description.name)
        expect(response.body).to not_include(@movies[0].name)
        expect(response.body).to not_include(@movies[1].name)
        expect(response.body).to not_include(@movies[2].name)
      end

      it 'ラジオボタンで公開中か公開前の切り替えができる' do
        expect(response.body).to include('type="radio"')
      end
    end
  end
end
