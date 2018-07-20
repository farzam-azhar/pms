class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:update_status, :update_role]
  
  def index
    @users = User.except_admin
  end
  
  def update_status
    @user.toggle_status!
    respond_to do |format|
      format.html { redirect_to admin_root_path, notice: 'User Successfully Enabled' }
      format.js
    end
  end
  
  def update_role
    @user.toggle_role!
    respond_to do |format|
      format.html { redirect_to admin_root_path, notice: 'User Successfully Demoted to User Role' }
      format.js
    end
  end
  
  private
  
    def set_user
      @user = User.find params[:id]
    end
end
