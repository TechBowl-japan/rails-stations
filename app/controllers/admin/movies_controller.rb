
class Admin::MoviesController < ApplicationController
    def index 
      @movies = Movie.all
    end
end

# Admin:: は名前空間を表す、:: は名前空間の区切り文字
# ディレクトリ構造との対応している
# app/
# └── controllers/
#     └── admin/              # 名前空間に対応
#         └── movies_controller.rb  # コントローラーファイル