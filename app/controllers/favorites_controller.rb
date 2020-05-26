class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.where(user_id:current_user.id)
  end

  def create
    @favorite = Favorite.create(favorite_params)
    redirect_to request.referer
  end

  def destroy
    @product = Product.find(params[:id])
    @favorite = Favorite.find_by(user_id: current_user.id, product_id: params[:id])
    @favorite.destroy
    redirect_to request.referer
  end

  private
  def favorite_params
    params.permit(:product_id).merge(user_id:current_user.id)
  end

end
