class InfomationsController < ApplicationController
  before_action :redirect_root,only:[:index,:show]
  before_action :set_products,only:[:index,:show]

  def index
  end

  def show
  end

  private
  def set_products
    @products = Product.includes(:images).where(user_id: current_user.id).where(status: 0).order("id DESC")
  end

  def redirect_root
    redirect_to root_path unless user_signed_in?
  end

end