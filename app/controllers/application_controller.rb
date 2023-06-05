class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

    rescue_from CanCan::AccessDenied do 
        redirect_to root_url, :alert => "You are un-authorize to perform this action."
      end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end
end
