require 'rails_helper'
RSpec::Matchers.define_negated_matcher :not_include, :include

RSpec.describe MoviesController, type: :controller do
  render_views
  describe 'Station5 DELETE /movies/:id' do
    let!(:movie) { create(:movie) }
    it 'リクエストを送ると320が返り、movies(:id)のレコードが消えること' do
      expect do
        delete :destroy, params: { id: movie.id }, session: {}
      end.to change(Movie, :count).by(-1)
      expect(response).to have_http_status(302)
    end
  
    it ':idのレコードが存在しないときRecordNotFound(400)が返る' do
      nothingMovieId = movie.id + 1
      expect do
        delete :destroy, params: { id: nothingMovieId }, session: {}
      end.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end