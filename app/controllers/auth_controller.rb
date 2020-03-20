class AuthController < ApplicationController
  def create
    authorize :auth
    user = User.find_or_create_by(email: params[:email])
    UserMailer.with(user: user).sign_up.deliver_now
    redirect_to root_path, success: t('.link_sent')
  end

  def activate
    authorize :auth
    user_id = JwtAuth.decrypt(params[:token])
    session[:user_id] = User.find(user_id).id
    redirect_to root_path, success: t('.logged_in')
  end
end
