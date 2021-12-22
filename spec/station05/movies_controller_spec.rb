require 'rails_helper'

RSpec.describe Admin::MoviesController, type: :controller do
  render_views
  describe 'Station5 DELETE admin/movies/:id' do
    before do
      @movie = create(:movie)
    end

    it 'リクエストを送ると320が返り、movies(:id)のレコードが消えること' do
      expect do
        delete :destroy, params: { id: @movie.id }, session: {}
      end.to change(Movie, :count).by(-1)

      expect(response).to have_http_status(302)
    end

    it ':idのレコードが存在しないときRecordNotFound(400)が返る' do
      nothing_movie_id = @movie.id + 1
      expect do
        delete :destroy, params: { id: nothing_movie_id }, session: {}
      end.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
