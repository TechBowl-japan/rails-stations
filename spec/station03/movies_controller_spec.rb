require 'rails_helper'

RSpec.describe Admin::MoviesController, type: :controller do
  render_views
  describe 'Station3 GET /admin/movies/new' do
    before do
      get :new
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
    let(:movie_attributes) { attributes_for(:movie) }

    it '302を返すこと' do
      post :create, params: { movie: movie_attributes }, session: {}
      expect(response).to have_http_status(302)
    end

    it 'エラー処理がされていて仮にRailsデフォルトのエラー画面が出ないこと' do
      # nameの一意は条件に入っているため、わざと重複させてバリデーションエラーを起こす
      create(:movie, name: "重複する名前")
      post :create, params: { movie: { name: "重複する名前", is_showing: true ,image_url: "https://techbowl.co.jp/_nuxt/img/test.png" } }, session: {}

      expect(response.body).not_to include('<div class="source hidden" id="frame-source-0-0">') # Railsのデフォルトのエラー画面のHTML要素
    end

    it 'DBに保存されていること' do
      expect do
        post :create, params: { movie: movie_attributes }, session: {}
      end.to change(Movie, :count).by(1)
    end
  end
end