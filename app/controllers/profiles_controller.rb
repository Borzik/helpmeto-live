class ProfilesController < ApplicationController
  skip_before_action :verify_account

  def edit
  end
  def edit_recipient
    current_user.update_column(:kind, :recipient)
  end
  def edit_volunteer
    current_user.update_column(:kind, :volunteer)
  end

  def update
    current_user.update(profile_params)
    redirect_to "/"
  end

  private
  def profile_params
    params.require(:user).permit(:name, :bio, :kind, :lc_lat, :lc_lng)
  end
end
