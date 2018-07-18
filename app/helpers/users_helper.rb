module UsersHelper
  def new_or_existing_photo(user)
    if user.photo.nil?
      user.build_photo
    end
  end
end
