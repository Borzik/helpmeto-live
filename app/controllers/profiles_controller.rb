class ProfilesController < ApplicationController
  skip_before_action :verify_account

  def edit
  end

  def update
    current_user.update(profile_params)
    redirect_to "/"
  end

  private
  def profile_params
    params.require(:user).permit(:name, :bio, :kind)
  end
end
