class ApplicationController < ActionController::Base
    def hello
        render html: "hello, world!"
    end

    def movies
        render template: "movies/index"
    end
end
