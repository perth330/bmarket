class ProductsController < ApplicationController
  def index
    @categoryProducts = Product.includes(:images).limit(3).order("id DESC")
    @categoryBrand = Product.includes(:images).limit(3).order("RAND()")
  end
  def show
    @product = Product.find(params[:id])
  end
end