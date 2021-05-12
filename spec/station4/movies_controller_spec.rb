require 'rails_helper'
RSpec::Matchers.define_negated_matcher :not_include, :include

RSpec.describe MoviesController, type: :controller do
  render_views
  describe 'Station4 GET /admin/movies/:id/edit' do
    before do
      @movie = create(:movie)
      get 'edit', params: {id: @movie.id}
    end

    it '200を返すこと' do
      expect(response).to have_http_status(200)
    end

    it 'HTMLを返すこと' do
      expect(response.body).to include('<!DOCTYPE html>')
    end

    it 'HTMLの中にはformタグがあること' do
      expect(response.body).to include('</form>')
    end

    it 'フォーム内に予め movies(:id) のレコードに対応する値が入っていること' do
      expect(response.body).to include(@movie.name)
    end
  end
end