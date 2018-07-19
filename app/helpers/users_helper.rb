module UsersHelper
  def new_or_existing_photo(user)
    if user.photo.nil?
      user.build_photo
    end
  end
  
  def select_options_for_gender
    [["Male", "M"], ["Female", "F"]]
  end
  
  def gender_select_prompt
    { prompt: 'Select Gender' }
  end
  
  def get_user_profile_picture
    if current_user.photo.present?
      image_tag current_user.photo.data.url(:thumb), class: "img-responsive img-circle pull-right pd-l-8 mt_5"
    end
  end
  
  def get_gender(gender)
    gender == 'M' ? 'Male' : 'Female'
  end
end
