class OffersMailer < ApplicationMailer
  def received_offer
    @user = params[:user]
    @offer = params[:offer]
    mail(to: @user.email, subject: t('offers_mailer.received_offer.subject'))
  end
end
