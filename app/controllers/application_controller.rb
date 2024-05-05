class ApplicationController < ActionController::Base
    
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
        movies_path
    end

    def respond_with(resource, _opts = {})
        if resource.persisted?
            sign_in(resource) if !user_signed_in?
            redirect_to after_sign_in_path_for(resource), status: 302
        else
            super
        end
    end

    private
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
