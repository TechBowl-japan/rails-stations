class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  rescue_from ActionController::RoutingError, with: :rescue404
  rescue_from Exception, with: :rescue500

  def rescue404(e)
    render "errors/not_found", status: 404
  end
  
  def rescue500(e)
    render "errors/internal_server_error", status: 500
  end
end
