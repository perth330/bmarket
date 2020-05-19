class PurchaseController < ApplicationController
  require 'payjp'

  def new
    Payjp.api_key = "秘密鍵"
    @product = Product.find(params[:product_id])
    @credit = Payjp::Customer.retrieve(current_user.credit.customer_id).cards.retrieve(current_user.credit.card_id)
    @purchase = Purchase.new
    @address = current_user.address
  end

  def create
    @product = Product.find(params[:product_id])
    credit = current_user.credit
    Payjp.api_key = "秘密鍵"
    Payjp::Charge.create(
      amount: @product.price,
      card: credit.card_id,
      currency: 'jpy'
    )
    @purchase = Purchase.new(create_purchase)
  end

  private
  def create_purchase
    params.require(:purchase).permit(:address_id).merge(seller_id:@product.user_id,buyer_id:current_user.id)
  end
end
