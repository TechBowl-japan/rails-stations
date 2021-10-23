class Movie < ApplicationRecord
  validates :name, uniqueness: true
  validates :image_url, length: { maximum: 150 }

  with_options presence: true do
    validates :year
    validates :description
    validates :image_url
    validates :name
  end

  attr_accessor :flg

  def self.set_init
  
  end

  scope :search, -> (movie_search_params) do
    return if movie_search_params.blank?
    # search_paramsが空の場合以降の処理を行わない

    # パラメータを指定して検索を実行
    name_like(movie_search_params).filter_is_showing(movie_search_params)
  end
  # nameが存在する場合、nameをlike検索する
  scope :name_like, -> (movie_search_params) { where('name LIKE?', "%#{movie_search_params[:keyword]}%").or(where('description LIKE?', "%#{movie_search_params[:keyword]}%")) if movie_search_params[:keyword].present? }
  # is_showingが存在する場合、true or falseを返す
  scope :filter_is_showing, -> (movie_search_params) { where(is_showing: movie_search_params[:is_showing]) if movie_search_params[:is_showing].present? }
end

# Scopeとは、ActiveRecordのQueryメソッドに名前を付ける機能
# 戻り値はActiveRecord::Relationオブジェクトなので、ScopeからScopeを呼び出すことも可能