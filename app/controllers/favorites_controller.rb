class FavoritesController < ApplicationController

  def create
    @favorite = Favorite.create(user_id: current_user.id, product_id: params[:product_id])
    @favorites = Favorite.where(product_id: params[:product_id])
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, product_id: params[:product_id])
    @favorite.destroy
    @favorites = Favorite.where(product_id: params[:product_id])
  end

  def set_item
    @product = Product.find(params[:product_id])
    @products = Product.includes(:images).order(:product_purchase_id, "id DESC")
  end


end
