class AuthController < ApplicationController
  def create
    user = User.find_or_create_by(email: params[:email])
    UserMailer.with(user: user).sign_up.deliver_now
    redirect_to '/', success: 'We have sent a link to log in to your email'
  end

  def activate
    user_id = JwtAuth.decrypt(params[:token])
    session[:user_id] = User.find(user_id).id
    redirect_to '/', success: 'You are now logged in'
  end
end
