class Admin::SchedulesController < ApplicationController
    # 特定のアクションの前に実行する共通処理
    # show, edit, update, destroyアクションの前にスケジュールを取得
    before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  
    # 全ての映画とそれに紐づくスケジュールを取得し、映画ごとにグループ化
    def index
      @schedules_by_movie = Schedule.includes(:movie).group_by(&:movie)
    end
  
    # 特定のスケジュールの詳細を表示
    def show
    end
  
    # 新規スケジュール作成フォームを表示
    # URLのmovie_idから対象の映画を取得し、その映画の新規スケジュールを作成
    def new
      @movie = Movie.find(params[:movie_id])
      @schedule = @movie.schedules.new
    end
  
    # 新規スケジュールをデータベースに保存
    def create
      @movie = Movie.find(params[:movie_id])
      @schedule = @movie.schedules.build(schedule_params)
  
      # 保存成功時は一覧ページへリダイレクト、失敗時は新規作成フォームを再表示
      if @schedule.save
        redirect_to admin_schedules_path, notice: "スケジュールを追加しました。"
      else
        render :new
      end
    end
  
    # スケジュール編集フォームを表示
    def edit
    end
  
    # データベースのスケジュールを更新
    def update
      # 更新成功時は詳細ページへリダイレクト、失敗時は編集フォームを再表示
      if @schedule.update(schedule_params)
        redirect_to admin_schedule_path(@schedule), notice: "スケジュールを更新しました。"
      else
        render :edit
      end
    end
  
    # スケジュールをデータベースから削除
    def destroy
      @schedule.destroy
      redirect_to admin_schedules_path, notice: "スケジュールを削除しました。"
    end
  
    private
  
     # URLのidパラメータから対象のスケジュールを取得
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end
  
    # 許可されたパラメータのみを取得（セキュリティ対策）
    def schedule_params
      params.require(:schedule).permit(:start_time, :end_time, :screen_id)
    end
  end