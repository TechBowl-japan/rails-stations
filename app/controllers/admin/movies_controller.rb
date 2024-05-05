module Admin
  class MoviesController < ApplicationController
    def index
      @movies = Movie.all

      if params[:keyword].present?
        @movies = @movies.where("name LIKE ? OR description LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      end
  
      if params[:is_showing].present?
        @movies = @movies.where(is_showing: params[:is_showing] == '1')
      end
    end

    def new
        @movie = Movie.new
    end

    def create
      @movie = Movie.new(movie_params)
      if @movie.save
        flash[:notice] = "映画の登録に成功しました。"
        redirect_to admin_movies_path
      else
        flash.now[:notice] = "映画の登録に失敗しました"
        render :new
      end
    end

    def edit
      @movie = Movie.find(params[:id])
    end

    def update
      @movie = Movie.find(params[:id])
      if @movie.update(movie_params)
        redirect_to admin_movies_path, notice: '映画情報が正常に更新されました。'
      else
        flash.now[:notice] = "映画情報の更新に失敗しました"
        render :new
      end
    end

    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      redirect_to admin_movies_path, notice: '映画が正常に削除されました。'
    end

    def show
      @movie = Movie.find(params[:id])
      @schedules = @movie.schedules
    end

    private

    def movie_params
      params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing, :screen_id)
    end

  end
end