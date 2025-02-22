class Admin::ReservationsController < ApplicationController
    before_action :set_reservation, only: [:edit, :update, :destroy]

    # 予約一覧（上映が終了したものは表示しない）
    def index
        @reservations = Reservation.joins(schedule: :movie)
            .includes(schedule: :movie, sheet: {})
            # .where("schedules.start_time > ?", Time.current)
            .order(created_at: :desc)
    end

    # 予約詳細
    def show
        @reservation = Reservation.find(params[:id])
    end

    # 予約追加
    def new
        @reservation = Reservation.new
    end

    # 予約作成
    def create
        @reservation = Reservation.new(reservation_params)
        if @reservation.save
            redirect_to admin_reservations_path, notice: "予約を追加しました"
        else
            flash[:alert] = @reservation.errors.full_messages.join(", ")
            render :new, status: :bad_request
        end
    end

    # 予約編集フォーム
    def edit
    end

    # 予約更新
    def update
        if @reservation.update(reservation_params)
          redirect_to admin_reservations_path, notice: "予約が更新されました。"
        else
          flash[:alert] = @reservation.errors.full_messages.join(", ")
            render :edit, status: :bad_request
        end
    end

    # 予約削除
    def destroy
        @reservation.destroy
        redirect_to admin_reservations_path, notice: "予約を削除しました。"
    end

    private

    # 予約パラメータ
    def set_reservation
        @reservation = Reservation.find(params[:id])
    end

    # 予約取得
    def reservation_params
        params.require(:reservation).permit(:date, :schedule_id, :sheet_id, :name, :email)
    end
end

