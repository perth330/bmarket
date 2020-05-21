class CreditsController < ApplicationController
  require "payjp"
  # before_action :set_card
  
  def new
    #カードがすでに登録されてる際の挙動はとりあえず置いとくなりなんなり。
    # redirect_to "/users/#{current_user.id}" if @credit.present?
    @credit = Credit.new
    
  end
  
  def create
    Payjp.api_key = '秘密鍵'
    token = Payjp::Token.create({
    :card => {
    :number => card_params[:card_number],
    :cvc => card_params[:cvc],
    :exp_month => card_params[:exp_month],
    :exp_year => card_params[:exp_year]
    }},
    {
    'X-Payjp-Direct-Token-Generate': 'true'})
    if token.blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: 'test',
      email: current_user.email,
      card: token,
      metadata: {user_id: current_user.id}
      )
      @credit = Credit.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @credit.save
        redirect_to "/users/#{current_user.id}"
      else
        render "new"
      end
    end
  end
  
  
  
  private
  
  def set_card
    @credit = Credit.where(user_id: current_user.id).first if Credit.where(user_id: current_user.id).present?
  end
  def card_params
    params.require(:credit).permit(:card_number,:exp_month,:exp_year,:cvc)
  end
  
end