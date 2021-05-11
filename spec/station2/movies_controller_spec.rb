require 'rails_helper'
RSpec::Matchers.define_negated_matcher :not_include, :include

RSpec.describe MoviesController, type: :controller do
  render_views
  describe 'Station2 GET /admin/movies' do
    before do
      @movies = create_list(:movie, 3)
      get 'index'
    end

    it '200を返すこと' do
      expect(response).to have_http_status(200)
    end

    it 'HTMLを返すこと' do
      expect(response.body).to include('<!DOCTYPE html>')
    end

    it 'HTMLの中にはtableタグがあること' do
      expect(response.body).to include('<table>')
    end

    it 'HTMLの中にはmoviesテーブルの件数と同じだけのデータがあること' do
      expect(response.body).to include(@movies[0].name).and include(@movies[1].name).and include(@movies[2].name).and include(@movies[0].image_url).and include(@movies[1].image_url).and include(@movies[2].image_url)
    end

    it 'HTMLの中にはtrue/falseが含まれないこと' do
      expect(response.body).to not_include('true').and not_include('false')
    end

    describe 'HTMLの中にはmoviesテーブルのカラムすべてが表示されていること' do
      it 'moviesテーブルのname,year,descriptionカラムが表示されていること' do
        expect(response.body).to include(@movies.first.name).and include(@movies.first.year).and include(@movies.first.description)
      end

      it 'moviesテーブル内のimage_urlが画像として表示されていること' do
        expect(response.body).to include("<img src=\"#{@movies.first.image_url}\"")
      end
    end
  end
end