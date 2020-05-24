class PurchasesController < ApplicationController
  require 'payjp'
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :new, :create]
  before_action :set_customer, only: [:show, :new, :create]
  before_action :set_credit, only: [:show, :new, :create]


  def show
  end

  def new
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    @purchase = Purchase.new
    @addresses = current_user.addresses
  end

  def create
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    token = Payjp::Charge.create(
      amount: @product.price,
      customer: @customer.id,
      card: @credit.id,
      currency: 'jpy'
    )
    if token.blank?
      render "new"
    end

    #bmarket DB保存
    @purchase = Purchase.new(create_purchase)
    if @purchase.save && @product.update(status:"売却済")
      redirect_to product_purchase_path(@product,@purchase)
    else
      render "new"
    end
  end

  private
  def create_purchase
    params.require(:purchase).permit(:address_id).merge(seller_id:@product.user_id,buyer_id:current_user.id,product_id:@product.id)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_customer
    @customer = Payjp::Customer.retrieve(current_user.credit.customer_id)
  end

  def set_credit
    @credit = @customer.cards.retrieve(current_user.credit.card_id)
  end
end
