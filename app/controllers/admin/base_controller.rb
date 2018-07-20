class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin
  protected
  
    def verify_admin
      redirect_to root_url, alert: 'You are not Authorized to Access this Page.' unless current_user.admin?
    end
end
