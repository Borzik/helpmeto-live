class AuthController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user
    else
      user = User.create(email: params[:email])
      UserMailer.with(user: user).sign_up.deliver_now
    end
    redirect_to '/'
  end

  def activate
    user_id = JwtAuth.decrypt(params[:token])
    session[:user_id] = User.find(user_id).id
    redirect_to '/'
  end
end
