class MainController < ApplicationController
  skip_after_action :verify_policy_scoped, only: :index
  skip_after_action :verify_authorized, only: %i[qa tos privacy_policy]
  before_action :redirect_to_need, only: :index

  def index
  end

  def qa
  end

  def tos
  end

  def privacy_policy
  end

  private

  # we want to keep recipients on their need page
  def redirect_to_need
    return unless logged_in?
    return unless current_user.recipient?
    return if current_user.need.nil?
    redirect_to my_need_path
  end
end
