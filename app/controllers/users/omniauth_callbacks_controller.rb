class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def shibboleth
    @user = User.find_for_shibboleth_oauth(request, current_user)
# if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Shibboleth") if is_navigational_format?
# else
# session["devise.shibboleth_data"] = request.env["omniauth.auth"]
# redirect_to new_user_registration_url
# end
  end
end
