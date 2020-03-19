class MainController < ApplicationController
  skip_after_action :verify_policy_scoped, only: :index
  skip_after_action :verify_authorized, only: %i[qa tos privacy_policy]
  def index
  end

  def qa
  end

  def tos
  end

  def privacy_policy
  end
end
