class UserMailer < ApplicationMailer
  def sign_up
    @user = params[:user]
    token = JwtAuth.encrypt(@user.id)
    @url = activate_auth_url(token: token)
    mail(to: @user.email, subject: t('user_mailer.sign_up.welcome'))
  end
end
