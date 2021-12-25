require 'rails_helper'
RSpec::Matchers.define_negated_matcher :not_include, :include

RSpec.describe Admin::MoviesController, type: :controller do
  render_views
  describe 'Station9 GET /admin/movies' do
    let!(:movies) { create_list(:movie, 3) }
    before do
      @schedules = create_list(:schedule, 3, movie_id: movies[0].id)
      get 'index'
    end

    it 'movies(:id)に対応するscheduleを表示していること' do
      expect(response.body).to include(@schedules[0].start_time.to_s).and include(@schedules[2].start_time.to_s)
    end


    describe 'HTMLの中にはmoviesテーブルのカラムすべてが表示されていること' do
      it 'moviesテーブルのname,year,descriptionカラムが表示されていること' do
        expect(response.body).to include(movies.first.name).and include("#{movies.first.year}").and include(movies.first.description)
      end

      it 'moviesテーブル内のimage_urlが画像として表示されていること' do
        expect(response.body).to include("<img src=\"#{movies.first.image_url}\"")
      end
    end

    context "Station02の仕様" do
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
        expect(response.body).to include(movies[0].name).and include(movies[1].name).and include(movies[2].name).and include(movies[0].image_url).and include(movies[1].image_url).and include(movies[2].image_url)
      end

      it 'HTMLの中にはtrue/falseが含まれないこと' do
        expect(response.body).to not_include('true').and not_include('false')
      end
    end
  end
end