class CreditsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :destroy]
  require "payjp"

  def new
    @credit = Credit.new
  end

  def create
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
    token = Payjp::Token.create({
      card: {
        number: card_params[:card_number],
        cvc: card_params[:cvc],
        exp_month: card_params[:exp_month],
        exp_year: card_params[:exp_year],
      },
    },
                                { 'X-Payjp-Direct-Token-Generate': "true" })

    if token.blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
        description: "test",
        email: current_user.email,
        card: token,
        metadata: { user_id: current_user.id },
      )
      #bmarketのDBに反映
      @credit = Credit.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @credit.save
        redirect_to "/credits/show"
      else
        render "new"
      end
    end
  end

  def show
    credit = Credit.find_by(user_id: current_user.id)
    if credit.blank?
      redirect_to new_credit_path
    else
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(credit.customer_id)
      @credit_information = customer.cards.retrieve(credit.card_id)
    end
  end

  def destroy #PayjpとCardデータベースを削除
    credit = Credit.find_by(user_id: current_user.id)
    if credit.present?
      Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_SECRET_KEY)
      customer = Payjp::Customer.retrieve(credit.customer_id)
      customer.delete
      credit.delete
    end
    redirect_to user_path(current_user), notice: "クレジットカード削除が完了しました。"
  end

  private

  #def set_card
  #@credit = Credit.where(user_id: current_user.id).first if Credit.where(user_id: current_user.id).present?
  #end
  def card_params
    params.require(:credit).permit(:card_number, :exp_month, :exp_year, :cvc)
  end
end
