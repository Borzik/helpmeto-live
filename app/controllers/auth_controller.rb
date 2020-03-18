class AuthController < ApplicationController
  def create
    user = User.find_or_create_by(email: params[:email])
    UserMailer.with(user: user).sign_up.deliver_now
    redirect_to '/', success: t('.link_sent')
  end

  def activate
    user_id = JwtAuth.decrypt(params[:token])
    session[:user_id] = User.find(user_id).id
    redirect_to '/', success: t('.logged_in')
  end
end
