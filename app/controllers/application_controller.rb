class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :verify_account

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  private
  def verify_account
    if logged_in? && (@current_user.name.empty? || @current_user.bio.empty?)
      redirect_to edit_profile_path
    end
  end
end
