require 'rails_helper'

RSpec.describe SeatsController, type: :controller do
  render_views
  describe 'Station7 GET /seats' do
    before do
      @seats = create_list(:seat, 20)
      get :index
    end

    it '200を返すこと' do
      expect(response).to have_http_status(200)
    end

    it 'HTMLの中にはtableタグがあること' do
      expect(response.body).to include('</table>')
    end

    it '実装の中でseatsテーブルにアクセスして、マスを固定値で固めていないこと。' do
      expect(response.body).to include("#{@seats.first.column}")
      expect(response.body).to include("#{@seats.last.column}")
    end
  end
end
