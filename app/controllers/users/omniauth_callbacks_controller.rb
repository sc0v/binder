class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def shibboleth
    @user = User.find_for_shibboleth_oauth(request, current_user)
    sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    set_flash_message(:notice, :success, :kind => "Shibboleth") if is_navigational_format?
  end
end
