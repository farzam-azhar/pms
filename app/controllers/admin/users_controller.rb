class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all_users_except_admin
  end
end
