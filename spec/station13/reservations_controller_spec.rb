require 'rails_helper'

RSpec.describe Admin::ReservationsController, type: :controller do
  render_views
  describe 'Station12 GET /admin/reservations' do
    before do
      sheets = create_list(:sheet, 3)
      schedule = create(:schedule, movie_id: create(:movie).id)
      @first_reservation = create(:reservation, schedule_id: schedule.id, sheet_id: sheets.first.id)
      create(:reservation, schedule_id: schedule.id, sheet_id: sheets[1].id) # 予約を3つ作成する
      @last_reservation = create(:reservation, schedule_id: schedule.id, sheet_id: sheets.last.id)
      get :index
    end

    it ' 200が返ること' do
      expect(response).to have_http_status(200)
    end

    it '予約を全件出力していること' do
      expect(response.body).to include(@first_reservation.name).and include(@first_reservation.name)
      expect(response.body).to include(@last_reservation.email).and include(@last_reservation.email)
    end
  end

  describe 'Station12 GET /admin/reservations/new' do
    before { get :new }

    it '200が返ること' do
      expect(response).to have_http_status(200)
    end

    it 'name, email, schedule_id, sheet_idのすべてを受け取るフォームがあること' do
      expect(response.body).to include("name")
      expect(response.body).to include("email")
      expect(response.body).to include("schedule_id")
      expect(response.body).to include("sheet_id")
    end
  end

  describe 'Station12 POST /admin/reservations/' do
    it 'schedule_id, sheet_id, name, email, dateのすべてがあるときに302を返す' do
      movie = create(:movie)
      sheet = create(:sheet)
      schedule = create(:schedule, movie_id: movie.id)
      post :create, params: { reservation: { name: "TEST_NAME", email: "test@test.com", date: "2019-04-16", sheet_id: sheet.id , schedule_id: schedule.id, movie_id: movie.id }}, session: {}

      expect(response).to have_http_status(302)
    end

    it 'DBのunique制約にあたったときなどは400を返すこと' do
      movie = create(:movie)
      sheet = create(:sheet)
      schedule = create(:schedule, movie_id: movie.id)
      # 同じ日付の同じ映画の座席を予約してみる
      create(:reservation, { sheet_id: sheet.id, schedule_id: schedule.id, date: "2019-04-16" })
      post :create, params: { reservation: { name: "TEST_NAME", email: "test@test.com", date: "2019-04-16", sheet_id: sheet.id , schedule_id: schedule.id, movie_id: movie.id }}, session: {}

      expect(response).to have_http_status(400)
    end
  end

  describe 'Station12 GET /admin/reservations/:id' do
    before do
      movie = create(:movie)
      sheet = create(:sheet)
      schedule = create(:schedule, movie_id: movie.id)
      @reservation = create(:reservation, { sheet_id: sheet.id, schedule_id: schedule.id })

      get :show, params: { id: @reservation.id }
    end

    it 'name, email, schedule_id, sheet_idのすべてを受け取るフォームがあること' do
      expect(response.body).to include("name")
      expect(response.body).to include("email")
      expect(response.body).to include("schedule_id")
      expect(response.body).to include("sheet_id")
    end

    it 'DB上のデータがすでにフォームに入っていること' do
      expect(response.body).to include(@reservation.name)
      expect(response.body).to include(@reservation.email)
    end
  end

  describe 'Station12 PUT /admin/reservations/:id' do

    it 'schedule_id, sheet_id, name, emailのすべてがあるときだけ302にすること' do
      # NOTE: とりあえず更新が成功するかだけ確認する
      movie = create(:movie)
      sheet = create(:sheet)
      schedule = create(:schedule, movie_id: movie.id)
      reservation = create(:reservation, { sheet_id: sheet.id, schedule_id: schedule.id, date: "2019-04-16" }) # NOTE: FactoryBotの影響でdateが自動生成しないため、ここでdateを指定する

      put :update, params: { id: reservation.id, reservation: { name: "TEST_NAME_updated", email: "test_email_updated@test.com", schedule_id: schedule.id, sheet_id: sheet.id }}, session: {}
      expect(response).to have_http_status(302)
    end
  end

  describe 'Station12 DELETE /admin/reservations/:id' do

    it 'reservationテーブルから:idのレコードを物理削除していること' do
      movie = create(:movie)
      sheet = create(:sheet)
      schedule = create(:schedule, movie_id: movie.id)
      reservation = create(:reservation, { sheet_id: sheet.id, schedule_id: schedule.id, date: "2019-04-16" }) # NOTE: FactoryBotの影響でdateが自動生成しないため、ここでdateを指定する

      expect do
        delete :destroy, params: { id: reservation.id }, session: {}
      end.to change(Reservation, :count).by(-1)
    end
  end
end
