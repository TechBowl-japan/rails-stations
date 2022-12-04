class Admin::MoviesController < ApplicationController
    def index
        @movies = Movie.all
        render plan: "ok", status: 200
    end
end
