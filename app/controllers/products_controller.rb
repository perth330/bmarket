class ProductsController < ApplicationController
  def index
  end
  def new
    @product = Product.new
    @categories = Category.all
    @brand = Brand.new
  end
  
  def create
    @brand = Brand.find_by(name: "#{brand_params}")
    @brand = Brand.create(brand_params) if @brand == nil
    @product = Product.create(product_create_params)
    redirect_to root_path
  end
  
  private
  def product_create_params
    params.require(:product).permit(:name,:introduction,:size,:category_id,:condition,:delivery_cost,:from,:delivery_day,:price).merge(user_id:current_user.id,status:"出品中",brand_id:@brand.id)
  end
  
  def brand_params
    params[:product].require(:brand).permit(:name)
  end
end
