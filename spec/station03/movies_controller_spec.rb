require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  render_views
  describe 'Station3 GET /admin/movies/new' do
    before do
      get 'new'
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

    it '改行したテキストの送信時にDBに改行コードは許容されるか' do
      expect(response.body).to include('</textarea>')
    end
  end

  describe 'Station3 POST /admin/movies' do
    let!(:movie_attributes) { attributes_for(:movie) }

    it '302を返すこと' do
      post :create, params: { movie: movie_attributes }, session: {}
      expect(response).to have_http_status(302)
    end

    it 'エラー処理がされていて仮にRailsデフォルトのエラー画面が出ないこと' do
      # 今回はデータベースエラーで例外処理
      post :create, params: { movie: { name: "test", is_showing: true ,image_url: "https://techbowl.co.jp/_nuxt/img/111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111lllllllllllll.png" } }, session: {}
      expect(response).to have_http_status(:ok)
    end

    it 'DBに保存されていること' do
      expect do
        post :create, params: { movie: movie_attributes }, session: {}
      end.to change(Movie, :count).by(1)
    end
  end
end