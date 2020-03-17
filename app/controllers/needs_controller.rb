class NeedsController < ApplicationController
  def show
    @need = params[:id] ? Need.find(params[:id]) : current_user.need
  end
  def new
    @need = Need.new
  end
  def create
    @need = current_user.create_need(need_params)
    redirect_to '/'
  end
  def edit
    @need = current_user.need
  end
  def update
    @need = current_user.need.update(need_params)
    redirect_to '/'
  end
  def destroy
    current_user.need.destroy
    redirect_to '/'
  end
  private
  def need_params
    params.require(:need).permit(:description, :lc_lat, :lc_lng)
  end
end