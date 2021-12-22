require 'rails_helper'

RSpec.describe Admin::MoviesController, type: :controller do
  render_views
  before do
    @movie = create(:movie)
  end

  describe 'Station4 GET /admin/movies/:id/edit' do
    before { get 'edit', params: {id: @movie.id} }

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

  describe 'Station4 PUT /admin/movies/:id' do
    let(:movie_update_attributes) { { name: "TEST" } }

    it '302を返すこと' do
      put :update, params: { id: @movie.id, movie: movie_update_attributes }, session: {}
      expect(response).to have_http_status(302)
    end

    it 'エラー処理がされていて仮にRailsデフォルトのエラー画面が出ないこと' do
      # nameの一意は条件に入っているため、わざと重複させてバリデーションエラーを起こす
      create(:movie, name: "重複する名前")
      put :update, params: { id: @movie.id, movie: { name: "重複する名前" } }, session: {}

      expect(response.body).not_to include('<div class="source hidden" id="frame-source-0-0">') # Railsのデフォルトのエラー画面のHTML要素
    end
  end
end
