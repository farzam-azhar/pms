class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:update_status, :update_role]
  before_action :validate_user_provider, only: [:update_status, :update_role]

  def index
    @users = User.except_admin
  end

  def update_status
    @user.toggle_status!
    status = @user.enabled? ? 'Enabled' : 'Disabled'

    respond_to do |format|
      format.html { redirect_to admin_root_path, notice: "User Successfully #{status}" }
      format.js
    end
  end

  def update_role
    @user.toggle_role!
    role = @user.user? ? 'User' : 'Manager'

    respond_to do |format|
      format.html { redirect_to admin_root_path, notice: "User Successfully Updated to #{role} Role" }
      format.js
    end
  end

  private

    def set_user
      @user = User.find params[:id]
    end

    def validate_user_provider
      unless @user.user_providers.empty?
        @user.provider = @user.uid = true
      end
    end
end
