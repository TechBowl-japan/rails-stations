require 'rails_helper'

RSpec.describe Admin::MoviesController, type: :controller do
  render_views
  describe 'Station4 GET /admin/movies/:id/edit' do
    let!(:movie) { create(:movie) }
    before { get 'edit', params: {id: movie.id} }

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
      expect(response.body).to include(movie.name)
    end
  end

  describe 'Station4 PUT /admin/movies/:id' do
    let!(:movie) { create(:movie) }
    let!(:movie_attributes) { { name: "TEST" } }

    it '302を返すこと' do
      post :update, params: { id: movie.id, movie: movie_attributes }, session: {}
      expect(response).to have_http_status(302)
    end

    it 'エラー処理がされていて仮にRailsデフォルトのエラー画面が出ないこと' do
      # 今回はデータベースエラーで例外処理
      post :update, params: { movie: { id: movie.id, image_url: "https://techbowl.co.jp/_nuxt/img/111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111lllllllllllll.png" } }, session: {}
      expect(response).to have_http_status(:ok)
    end
  end
end