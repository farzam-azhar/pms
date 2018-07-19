class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:enable_or_disable_user]
  
  def index
    @users = User.all_users_except_admin
  end
  
  def enable_or_disable_user
    if @user.disabled?
      @user.enabled!
      respond_to do |format|
        format.html { redirect_to admin_root_path, notice: 'User Successfully Enabled' }
        format.js
      end
    else
      @user.disabled!
      respond_to do |format|
        format.html { redirect_to admin_root_path, notice: 'User Successfully Disabled' }
        format.js
      end
    end
  end
  
  private
  
    def set_user
      @user = User.find params[:id]
    end
end
