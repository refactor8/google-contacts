class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = UserService.create(request.env['omniauth.auth'])
    @user.persisted? ? success : failure
  end

  def failure
    redirect_to root_path, alert: I18n.t('errors.access_not_granted')
  end

  private

  def success
    flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
    sign_in_and_redirect @user, event: :authentication
  end
end
