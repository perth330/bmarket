class PurchasesController < ApplicationController
  require 'payjp'

  def new
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    @product = Product.find(params[:product_id])
    customer = Payjp::Customer.retrieve(current_user.credit.customer_id)
    @credit = customer.cards.retrieve(current_user.credit.card_id)
    @purchase = Purchase.new
    @addresses = current_user.addresses
  end

  def create
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    @product = Product.find(params[:product_id])
    customer = Payjp::Customer.retrieve(current_user.credit.customer_id)
    credit = customer.cards.retrieve(current_user.credit.card_id)
    token = Payjp::Charge.create(
      amount: @product.price,
      customer: customer.id,
      card: credit.id,
      currency: 'jpy'
    )
    if token.blank?
      render "new"
    else
      purchase = Purchase.create(create_purchase)
      @product.update(status:"売却済")
    end
  end

  private
  def create_purchase
    params.require(:purchase).permit(:address_id).merge(seller_id:@product.user_id,buyer_id:current_user.id,product_id:@product.id)
  end
end
