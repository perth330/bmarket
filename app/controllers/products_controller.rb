class ProductsController < ApplicationController
  def index
    @categoryProducts = Product.includes(:images).limit(3).order("id DESC")
    @categoryBrand = Product.includes(:images).limit(3).order("RAND()")
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @categories = Category.roots
    @brand = Brand.new
    @product.images.new
  end
  
  def create
    if brand_params == ""
      @brand = Brand.find_by(name: "#{brand_params}")
      @brand = Brand.create(brand_params) if @brand == nil
    else
      @brand = Brand.find(1)
    end
    @product = Product.create(product_create_params)
    redirect_to root_path
  end
  
  private
  def product_create_params
    params.require(:product).permit(:name,:introduction,:size,:category_id,:condition,:delivery_cost,:from,:delivery_day,:price,images_attributes: [:src]).merge(user_id:current_user.id,status:"出品中",brand_id:@brand.id)
  end
  
  def brand_params
    params[:product].require(:brand).permit(:name)
  end
end

