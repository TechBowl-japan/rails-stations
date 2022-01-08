require 'rails_helper'
RSpec::Matchers.define_negated_matcher :not_include, :include

RSpec.describe Admin::MoviesController, type: :controller do
  render_views
  describe 'Station2 GET /admin/movies' do
    before do
      @movies = create_list(:movie, 3)
      get :index
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

    it 'HTMLの中にはmoviesテーブルのレコード数と同じ件数のデータがあること' do
      expect(response.body).to include(@movies[0].name)
      expect(response.body).to include(@movies[1].name)
      expect(response.body).to include(@movies[2].name)
      expect(response.body).to include(@movies[0].image_url)
      expect(response.body).to include(@movies[1].image_url)
      expect(response.body).to include(@movies[2].image_url)
    end

    it 'HTMLの中にはtrue/falseが含まれないこと' do
      expect(response.body).to not_include('true').and not_include('false')
    end

    describe 'HTMLの中にはmoviesテーブルのカラムすべてが表示されていること' do
      it 'moviesテーブルのname,year,descriptionカラムが表示されていること' do
        expect(response.body).to include(@movies.first.name)
        expect(response.body).to include("#{@movies.first.year}")
        expect(response.body).to include(@movies.first.description)
      end
    end
  end
end