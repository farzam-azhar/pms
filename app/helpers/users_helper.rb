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
end
