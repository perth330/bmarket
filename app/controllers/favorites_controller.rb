class FavoritesController < ApplicationController
  before_action :set_item, only: [:create, :destroy]

  def index
    @favorites = Favorite.where(user_id:current_user.id)
  end

  def create
    return nil if user.signed_in?
    return nil if @product.user_id == current_user.id or Favorite.find_by(product_id:@product.id,user_id:current_user.id) != nil
    @favorite = Favorite.create(user_id: current_user.id, product_id: params[:product_id])
    @favorites = Favorite.where(product_id: params[:product_id])
  end

  def destroy
    return nil if user.signed_in?
    return nil if @product.user_id == current_user.id or Favorite.find_by(product_id:@product.id,user_id:current_user.id) == nil
    @favorite = Favorite.find_by(user_id: current_user.id, product_id: params[:id])
    @favorite.destroy
    redirect_to request.referer
  end

  def set_item
    @product = Product.find(params[:id])
    @products = Product.includes(:images).order(:product_purchase_id, "id DESC")
  end


end
