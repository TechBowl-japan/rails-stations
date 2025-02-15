
class Admin::MoviesController < ApplicationController
    def index 
      @movies = Movie.all
    end

    def new
      @movie = Movie.new
    end

    def create
      @movie = Movie.new(movie_params)
      if @movie.save
        redirect_to admin_movies_path, notice: "映画が登録されました"
      else
        flash.now[:alert] = "登録に失敗しました"
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @movie = Movie.find(params[:id])
    end

    def update
      @movie = Movie.find(params[:id])
      if @movie.update(movie_params)
        redirect_to admin_movies_path, notice: "映画情報が更新されました"
      else
        flash.now[:aleart] = "更新に失敗しました"
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @movie = Movie.find(params[:id])
      @movie.destroy
      redirect_to admin_movies_path, notice: "映画「#{@movie.name}」を削除しました"
    end

    private

    def movie_params
      params.require(:movie).permit(:name, :year, :description, :image_url, :is_showing)
    end
end

# Admin:: は名前空間を表す、:: は名前空間の区切り文字
# ディレクトリ構造との対応している
# app/
# └── controllers/
#     └── admin/              # 名前空間に対応
#         └── movies_controller.rb  # コントローラーファイル