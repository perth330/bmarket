class InfomationsController < ApplicationController
  before_action :redirect_root,only:[:index,:show]

  def index
    @products = Product.includes(:images).where(user_id: current_user.id).where(status: 0).order("id DESC")
  end

  def show
    @products = Product.includes(:images).where(user_id: current_user.id).where(status: 1).order("id DESC")
  end

  private

  def redirect_root
    redirect_to root_path unless user_signed_in?
  end
end