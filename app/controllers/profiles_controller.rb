class ProfilesController < ApplicationController
  skip_before_action :verify_account

  def edit
  end
  def edit_recipient
    current_user.update_column(:kind, 1)
  end
  def edit_volunteer
    current_user.update_column(:kind, 2)
  end

  def update
    if current_user.update(profile_params)
      redirect_to root_path, success: 'Profile settings saved'
    else
      render_with_turbolinks current_user.volunteer? ? 'edit_volunteer' : 'edit_recipient'
    end
  end

  private
  def profile_params
    params.require(:user).permit(:name, :bio, :lc_lat, :lc_lng)
  end
end
