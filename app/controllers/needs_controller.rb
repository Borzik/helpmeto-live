class NeedsController < ApplicationController
  def index
    authorize Need
    @needs = policy_scope(Need)
    @needs_json = @needs.to_json(only: [:id, :description], methods: [:lc_lat, :lc_lng])
  end

  def show
    @need = params[:id] ? policy_scope(Need).find(params[:id]) : current_user.need
    authorize @need
  end

  def edit
    @need = current_user.need || current_user.build_need
    authorize @need
  end

  def update
    @need = current_user.need || current_user.build_need
    authorize @need
    if @need.update_attributes(need_params)
      redirect_to my_need_path, success: t('.success')
    else
      render_with_turbolinks 'edit'
    end
  end

  def destroy
    @need = current_user.need
    authorize @need
    @need.destroy
    redirect_to root_path, success: t('.success')
  end

  private
  def need_params
    params.require(:need).permit(:description, :lc_lat, :lc_lng)
  end
end