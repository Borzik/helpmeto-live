class MainController < ApplicationController
  skip_after_action :verify_policy_scoped, only: :index
  skip_after_action :verify_authorized, only: :qa
  def index
  end

  def qa
  end
end
