class OffersController < ApplicationController
  def index
    @offers = policy_scope(Offer)
  end

  def create
    @need = Need.find(params[:need_id])
    @offer = current_user.offers.build(offer_params.merge(need_id: @need.id))
    authorize @offer

    if @offer.save
      OffersMailer.with(user: @need.user, offer: @offer).received_offer.deliver_now
      redirect_to need_path(@need), success: 'Offer to help was successfully sent.'
    else
      render 'needs/show'
    end
  end

  private
    def offer_params
      params.require(:offer).permit(:message, :contact_info)
    end
end
