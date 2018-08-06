class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    resource.user_providers.present? ? resource.update_without_password(params) : super
  end
end
