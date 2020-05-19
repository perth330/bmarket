class PurchaseController < ApplicationController
  require 'payjp'

  def new
    @product = Product.find(params[:product_id])
    @credits = Credit.where(user_id:current_user.id)
    @purchase = Purchase.new
  end

  def create
    Payjp.api_key = "秘密鍵"
    Payjp::Charge.create(
      amount: 809, # 決済する値段
      card: params['payjp-token'], # フォームを送信すると作成・送信されてくるトークン
      currency: 'jpy'
    )
  end
end
