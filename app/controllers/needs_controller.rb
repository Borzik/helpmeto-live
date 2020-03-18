class NeedsController < ApplicationController
  def index
    @needs = Need.within_10km_from(current_user.location.to_s)
    @needs_json = @needs.to_json(only: [:id, :description], methods: [:lc_lat, :lc_lng])
  end
  def show
    @need = params[:id] ? Need.find(params[:id]) : current_user.need
  end
  def new
    if current_user.need
      redirect_to edit_my_need_path
    end
    @need = Need.new
  end
  def create
    @need = current_user.build_need(need_params)
    if @need.save
      redirect_to my_need_path, success: t('.success')
    else
      render_with_turbolinks 'new'
    end
  end
  def edit
    @need = current_user.need
  end
  def update
    @need = current_user.need
    if @need.update(need_params)
      redirect_to my_need_path, success: t('.success')
    else
      render_with_turbolinks 'edit'
    end
  end
  def destroy
    current_user.need.destroy
    redirect_to root_path, success: t('.success')
  end
  private
  def need_params
    params.require(:need).permit(:description, :lc_lat, :lc_lng)
  end
end