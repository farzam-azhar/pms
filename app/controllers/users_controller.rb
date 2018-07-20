class UsersController < ApplicationController
  def set_profile_picture
    if current_user.photo.present?
      if current_user.photo.update(photo_params)
        redirect_to edit_user_registration_path, notice: 'Profile picture is successfully updated'
      else
        redirect_to edit_user_registration_path, alert: 'Some Problem occured while updating Profile Picture.'
      end
    else
      if current_user.create_photo(photo_params)
        redirect_to edit_user_registration_path, notice: 'Profile picture is successfully updated'
      else
        redirect_to edit_user_registration_path, alert: 'Some Problem occured while updating Profile Picture.'
      end
    end
  end
  
  private
    def photo_params
      params.require(:user).require(:photo_attributes).permit(:data)
    end
end
