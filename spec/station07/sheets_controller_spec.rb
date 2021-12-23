require 'rails_helper'

RSpec.describe SheetsController, type: :controller do
  render_views
  describe 'Station7 GET /sheets' do
    before do
      @sheets = create_list(:sheet, 20)
      get :index
    end

    it '200を返すこと' do
      expect(response).to have_http_status(200)
    end

    it 'HTMLの中にはtableタグがあること' do
      expect(response.body).to include('</table>')
    end

    it '実装の中でsheetsテーブルにアクセスして、マスを固定値で固めていないこと。' do
      expect(response.body).to include("#{@sheets.first.column}")
      expect(response.body).to include("#{@sheets.last.column}")
    end
  end
end
