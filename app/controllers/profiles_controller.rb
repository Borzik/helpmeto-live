class ProfilesController < ApplicationController
  skip_before_action :verify_account

  def edit
    authorize :profile
  end

  def edit_recipient
    authorize :profile
    current_user.update_column(:kind, 1)
  end

  def edit_volunteer
    authorize :profile
    current_user.update_column(:kind, 2)
  end

  def update
    authorize :profile
    if current_user.update(profile_params)
      next_url = current_user.volunteer? ? root_path : edit_my_need_path
      redirect_to next_url, success: t('.success')
    else
      render_with_turbolinks current_user.volunteer? ? 'edit_volunteer' : 'edit_recipient'
    end
  end

  private
  def profile_params
    params.require(:user).permit(:name, :bio, :lc_lat, :lc_lng)
  end
end
