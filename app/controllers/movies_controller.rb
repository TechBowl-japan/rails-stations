class MoviesController < ApplicationController
    def index 
      @movies = Movie.all
      @movies = filter_by_showing_status(@movies)
      @movies = filter_by_keyword(@movies)
    end

    def show
      @movie = Movie.find(params[:id])
      @schedules = @movie.schedules ? @movie.schedules.order(:start_time) : nil
    end

    # 上映フィルタリング
    def filter_by_showing_status(movies)
      case params[:is_showing]
      when "1"
        movies.where(is_showing: true)
      when "0"
        movies.where(is_showing: false)
      else
        movies
      end
    end

    # タイトルフィルタリング
    def filter_by_keyword(movies)
      if params[:keyword].present?
        movies.where("name LIKE ? OR description LIKE ?",
          "%#{params[:keyword]}%",
          "%#{params[:keyword]}%")
      else
        movies
      end
    end

    def reservation
      if params[:date].blank? || params[:schedule_id].blank?
        redirect_to movie_path(params[:movie_id]), alert: "日付とスケジュールを選択してください。" and return
      end

      @movie = Movie.find(params[:movie_id])
      @schedule = Schedule.find(params[:schedule_id])
      # スケジュールに関連するスクリーンの座席を取得
      @sheets = Sheet.where(screen_id: @schedule.screen_id)
      # デバッグ用ログ出力
      Rails.logger.debug "Sheets for Screen #{@schedule.screen_id}: #{@sheets.map { |s| "#{s.row}-#{s.column}" }.join(', ')}"

      @reserved_sheets = Reservation.where(
        schedule_id: params[:schedule_id],
        # screen_id: @schedule.screen_id,
        sheet_id: @sheets.pluck(:id),
        date: Date.parse(params[:date]) # `params[:date]` を `Date` 型に変換
        ).pluck(:sheet_id)

        # デバック用コード
        puts "Schedule ID: #{@schedule.id}, Expected: #{params[:schedule_id]}"
        puts "Date Type: #{params[:date].class}, Expected: String"
        puts "Sheets for Screen #{@schedule.screen_id}: #{@sheets.map { |s| "#{s.row}-#{s.column}" }.join(', ')}"
        puts "Reservations Found: #{@reserved_sheets}"
    end
end
