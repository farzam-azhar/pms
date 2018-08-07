class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up){|u| u.permit(:username, :email, :password, :password_confirmation, :gender, :contact)}
      devise_parameter_sanitizer.permit(:sign_in){|u| u.permit(:email, :password, :remember_me)}
      devise_parameter_sanitizer.permit(:account_update){|u| u.permit(:username, :email, :password, :current_password, :gender, :contact)}
    end
    
    def after_sign_in_path_for(resource)
      resource.admin? ? admin_root_path : root_url
    end

    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s.underscore

      flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
      redirect_to(request.referrer || root_path)
     end
end
