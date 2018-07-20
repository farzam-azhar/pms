module UsersHelper
  def new_or_existing_photo(user)
    if user.photo.nil?
      user.build_photo
    end
  end
  
  def user_profile_picture
    if current_user.photo.present?
      image_tag current_user.photo.data.url(:thumb), class: "img-responsive img-circle pull-right pd-l-8 mt_5 img-size"
    end
  end
end
